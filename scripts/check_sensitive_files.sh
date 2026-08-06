#!/bin/bash

# ==============================================================================
# Pre-commit hook: Scans staged files for sensitive filenames and secret content.
#
# Fixes over v1:
#   - Reads staged content via `git show` (not disk) — catches staged-but-deleted secrets
#   - Skips commented lines before pattern matching — kills .env.example false positives
#   - Robust self-exclusion via script content marker — not fragile basename match
#   - Binary detection via git, not the `file` command — portable across macOS/Linux/CI
#   - Secrets are masked in output — no raw values in terminal/CI logs
#   - Broader pattern coverage (GitHub tokens, SSH keys, JWT secrets, etc.)
# ==============================================================================

set -euo pipefail

# ── Sensitive filenames (exact basename match) ─────────────────────────────────
SENSITIVE_FILENAMES=(
  "google-play-service-key.json"
  "firebase-admin-config.js"
  "google-services.json"
  "GoogleService-Info.plist"
  "secrets.json"
  "credentials.json"
  "service-account.json"
  "serviceAccountKey.json"
  ".npmrc"          # often contains auth tokens
  ".pypirc"         # PyPI upload credentials
)

# ── Secret content patterns ────────────────────────────────────────────────────
# Each entry is: "LABEL|||PATTERN"
# Keeping label and pattern together avoids the script matching its own patterns.
SECRET_PATTERNS=(
  "MongoDB SRV URI|||mongodb\+srv://[^:]+:[^@]+@[a-zA-Z0-9]"
  "MongoDB URI|||mongodb://[^:]+:[^@]+@[a-zA-Z0-9]"
  "Google API Key|||AIza[0-9A-Za-z\-_]{35}"
  "AWS Access Key ID|||AKIA[0-9A-Z]{16}"
  "Stripe Live Secret|||sk_live_[0-9a-zA-Z]{24,}"
  "Stripe Test Secret|||sk_test_[0-9a-zA-Z]{24,}"
  "GitHub Personal Token|||ghp_[0-9A-Za-z]{36}"
  "GitHub Fine-Grained Token|||github_pat_[0-9A-Za-z_]{82}"
  "Slack Token|||xox[baprs]-[0-9A-Za-z\-]{10,}"
  "Private Key Block|||-{5}BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-{5}"
  "Service Account Private Key|||\"private_key\"\s*:\s*\"-----BEGIN"
  "Generic JWT Secret|||[Jj][Ww][Tt][_\-]?[Ss][Ee][Cc][Rr][Ee][Tt]\s*[=:]\s*['\"]?[A-Za-z0-9/+=_\-]{16,}"
  "Generic API Key Assignment|||[A-Za-z0-9_]*[Aa][Pp][Ii][_]?[Kk][Ee][Yy][A-Za-z0-9_]*\s*[=:]\s*['\"]?[A-Za-z0-9/+=_\-]{20,}"
)

# ── Files/patterns to NEVER scan (content scan skip-list) ─────────────────────
# Basenames listed here are allowed to contain secret-looking strings.
CONTENT_SCAN_SKIP_BASENAMES=(
  # Template / example env files — contain placeholder secrets by design
  ".env.example"
  ".env.sample"
  ".env.template"

  # Lock files, changelogs, docs — low signal, high noise
  "package-lock.json"
  "yarn.lock"
  "pnpm-lock.yaml"
  "CHANGELOG.md"
  "CHANGELOG.txt"

  # Gitleaks allowlist config - contains benign regex rules, not secrets
  ".gitleaks.toml"
)

# Marker that lets the script skip itself regardless of what it's named.
# The grep below looks for this exact string in the staged file content.
SELF_MARKER="GIT_HOOK_SELF_MARKER_DO_NOT_SCAN"

# ── State ──────────────────────────────────────────────────────────────────────
found_sensitive_files=false
found_secrets=false

# ── Helpers ───────────────────────────────────────────────────────────────────

# Returns 0 (true) if the basename is a .env-style secret file.
# Returns 1 (false) for example/template variants, which are safe.
is_sensitive_env_file() {
  local base="$1"
  case "$base" in
    .env.example|.env.*.example|.env.sample|.env.*.sample|.env.template)
      return 1   # explicitly allowed
      ;;
    .env|.env.*)
      return 0   # blocked
      ;;
    *)
      return 1
      ;;
  esac
}

# Returns 0 if the basename is in the content scan skip-list.
is_content_scan_skipped() {
  local base="$1"
  for skip in "${CONTENT_SCAN_SKIP_BASENAMES[@]}"; do
    [[ "$base" == "$skip" ]] && return 0
  done
  # Also skip .env.*.example style dynamically
  [[ "$base" == .env.*.example || "$base" == .env.*.sample ]] && return 0
  return 1
}

# Masks all but the first 4 characters of a match to avoid leaking raw secrets.
mask_secret() {
  local value="$1"
  local visible=4
  local len=${#value}
  if (( len <= visible )); then
    printf '%s' "$value"
  else
    local masked
    masked=$(printf '%0.s*' $(seq 1 $((len - visible))))
    printf '%s%s' "${value:0:$visible}" "$masked"
  fi
}

# ── Collect staged files ───────────────────────────────────────────────────────
echo "🔒 Scanning staged files for sensitive content..."

staged_files=()
while IFS= read -r -d '' file; do
  staged_files+=("$file")
# --diff-filter=d skips deleted files — they have no staged content to scan
done < <(git diff --cached --name-only --diff-filter=d -z)

if [[ "${#staged_files[@]}" -eq 0 ]]; then
  echo "No files staged."
  exit 0
fi

# ── Main scan loop ─────────────────────────────────────────────────────────────
for file in "${staged_files[@]}"; do
  base="$(basename "$file")"

  # ── 1. Sensitive filename checks ──────────────────────────────────────────

  if is_sensitive_env_file "$base"; then
    echo "----------------------------------------------------------------"
    echo "ERROR: Attempting to commit sensitive file: $file"
    echo "Rule matched: env secret file (.env / .env.*)"
    echo "TIP:  Use .env.example as a template and keep $base in .gitignore"
    echo "----------------------------------------------------------------"
    found_sensitive_files=true
    continue   # no point scanning contents if we're already blocking it
  fi

  for sensitive_name in "${SENSITIVE_FILENAMES[@]}"; do
    if [[ "$base" == "$sensitive_name" ]]; then
      echo "----------------------------------------------------------------"
      echo "ERROR: Attempting to commit sensitive file: $file"
      echo "Rule matched: exact filename → $sensitive_name"
      echo "----------------------------------------------------------------"
      found_sensitive_files=true
      break
    fi
  done

  # ── 2. Content scan ───────────────────────────────────────────────────────

  # Skip files on the content-scan skip-list
  if is_content_scan_skipped "$base"; then
    continue
  fi

  # Read staged content from the git index (not the working tree)
  staged_content=$(git show ":$file" 2>/dev/null) || continue

  # Skip if this file contains our self-marker (i.e. this script itself,
  # regardless of what it was renamed to)
  if echo "$staged_content" | grep -q "$SELF_MARKER"; then
    continue
  fi

  # Skip binary files — git show marks them; piping through cat loses that,
  # so we check the cached diff header instead.
  if git diff --cached -p -- "$file" 2>/dev/null | head -1 | grep -q '^Binary'; then
    continue
  fi

  # Strip:
  #   - Lines that are pure comments (# …)
  #   - Inline comments at end of line (everything from whitespace+# onward)
  # This prevents patterns in commented-out examples from triggering.
  scannable_content=$(
    echo "$staged_content" \
      | grep -v '^\s*#' \
      | sed 's/[[:space:]]*#.*$//'
  )

  for entry in "${SECRET_PATTERNS[@]}"; do
    label="${entry%%|||*}"
    pattern="${entry##*|||}"

    match=$(echo "$scannable_content" | grep -E "$pattern" 2>/dev/null || true)
    if [[ -n "$match" ]]; then
      # Mask the actual secret value before printing
      masked_line=$(echo "$match" | head -1 | sed -E "s/($pattern)/[REDACTED]/g")
      echo "----------------------------------------------------------------"
      echo "ERROR: Potential secret found in: $file"
      echo "Type:  $label"
      echo "Line:  $masked_line"
      echo "----------------------------------------------------------------"
      found_secrets=true
    fi
  done
done

# ── Result ─────────────────────────────────────────────────────────────────────
if [[ "$found_sensitive_files" = true ]] || [[ "$found_secrets" = true ]]; then
  echo ""
  echo "❌ Commit rejected:"
  [[ "$found_sensitive_files" = true ]] && echo "   • Sensitive files staged for commit"
  [[ "$found_secrets"         = true ]] && echo "   • Potential secrets found in file contents"
  echo ""
  echo "   Unstage a file:           git reset HEAD <file>"
  echo "   Bypass (NOT recommended): git commit --no-verify"
  echo ""
  exit 1
fi

echo "✅ No sensitive files or secrets detected. Proceeding with commit."
exit 0