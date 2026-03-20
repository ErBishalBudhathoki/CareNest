#!/bin/bash

set -euo pipefail

# This script checks for sensitive files that are staged for commit.

# Exact sensitive filenames that should never be committed.
SENSITIVE_FILENAMES=(
  "google-play-service-key.json"
  "firebase-admin-config.js"
  "google-services.json"
  "GoogleService-Info.plist"
)

# Patterns to detect secrets in file contents
SECRET_PATTERNS=(
  'mongodb\+srv://[^:]+:[^@]+@'
  'mongodb://[^:]+:[^@]+@'
  'AIza[0-9A-Za-z\-_]{35}'
  'AKIA[0-9A-Z]{16}'
  'sk_live_[0-9a-zA-Z]{24,}'
  'sk_test_[0-9a-zA-Z]{24,}'
  'private_key.*:.*-----BEGIN'
)

found_sensitive_files=false
found_secrets=false

echo "🔒 Scanning staged files for sensitive content..."

is_sensitive_env_file() {
  local base_name="$1"

  case "$base_name" in
    .env.example|.env.*.example)
      # Explicitly allow template env files.
      return 1
      ;;
    .env|.env.*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

staged_files=()
while IFS= read -r -d '' file; do
  staged_files+=("$file")
done < <(git diff --cached --name-only -z)

if [[ "${#staged_files[@]}" -eq 0 ]]; then
  echo "No files staged."
  exit 0
fi

for file in "${staged_files[@]}"; do
  base_name="$(basename "$file")"

  if is_sensitive_env_file "$base_name"; then
    echo "----------------------------------------------------------------"
    echo "ERROR: Attempting to commit sensitive file: $file"
    echo "Rule matched: env secret file (.env, .env.*)"
    echo "----------------------------------------------------------------"
    found_sensitive_files=true
    continue
  fi

  for sensitive_name in "${SENSITIVE_FILENAMES[@]}"; do
    if [[ "$base_name" == "$sensitive_name" ]]; then
      echo "----------------------------------------------------------------"
      echo "ERROR: Attempting to commit sensitive file: $file"
      echo "Rule matched: exact filename $sensitive_name"
      echo "----------------------------------------------------------------"
      found_sensitive_files=true
    fi
  done
  
  # Scan file contents for secrets (skip binary files and exceptions)
  if [ -f "$file" ] && file "$file" | grep -q "text"; then
    # Skip this script itself and example env files
    if [[ "$base_name" == "check_sensitive_files.sh" ]] || [[ "$base_name" == ".env.example" ]] || [[ "$base_name" == ".env.development.example" ]]; then
      continue
    fi
    
    for pattern in "${SECRET_PATTERNS[@]}"; do
      match=$(grep -E "$pattern" "$file" 2>/dev/null || true)
      if [ -n "$match" ]; then
        echo "----------------------------------------------------------------"
        echo "ERROR: Potential secret found in $file"
        echo "Pattern: $pattern"
        echo "$match" | head -3
        echo "----------------------------------------------------------------"
        found_secrets=true
      fi
    done
  fi
done

if [[ "$found_sensitive_files" = true ]] || [[ "$found_secrets" = true ]]; then
  echo ""
  echo "❌ Commit rejected. Issues found:"
  [ "$found_sensitive_files" = true ] && echo "  - Sensitive files detected"
  [ "$found_secrets" = true ] && echo "  - Potential secrets in code"
  echo ""
  echo "You can unstage a file using: git reset HEAD <file>"
  echo "To bypass (NOT RECOMMENDED): git commit --no-verify"
  exit 1
fi

echo "✅ No sensitive files or secrets found. Proceeding with commit."
exit 0
