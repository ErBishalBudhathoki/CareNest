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

found_sensitive_files=false

echo "Scanning staged files for sensitive content..."

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
done

if [[ "$found_sensitive_files" = true ]]; then
  echo ""
  echo "ERROR: Aborting commit. Please unstage the sensitive files listed above."
  echo "You can unstage a file using: git reset HEAD <file>"
  echo "Make sure these files are added to .gitignore."
  echo "Refer to SENSITIVE_FILES_GUIDE.md for more information."
  exit 1
fi

echo "No sensitive files found in staged changes. Good to go!"
exit 0
