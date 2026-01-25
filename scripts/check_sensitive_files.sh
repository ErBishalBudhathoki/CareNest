#!/bin/bash

# This script checks for sensitive files that are STAGED for commit.

# List of sensitive file patterns (filenames or partial paths).
SENSITIVE_PATTERNS=(
  "google-play-service-key.json"
  "firebase-admin-config.js"
  "google-services.json"
  "GoogleService-Info.plist"
  ".env"
)

# Flag to track if sensitive files were found.
found_sensitive_files=false

echo "Scanning staged files for sensitive content..."

# Get list of staged files
staged_files=$(git diff --cached --name-only)

if [[ -z "$staged_files" ]]; then
    echo "No files staged."
    exit 0
fi

# Check each staged file against sensitive patterns
for file in $staged_files; do
    for pattern in "${SENSITIVE_PATTERNS[@]}"; do
        # Check if the file path contains the sensitive pattern
        # We check if the pattern appears anywhere in the path, or if the filename matches
        if [[ "$file" == *"$pattern"* ]]; then
            echo "----------------------------------------------------------------"
            echo "ERROR: Attempting to commit sensitive file: $file"
            echo "Pattern matched: $pattern"
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
else
  echo "No sensitive files found in staged changes. Good to go!"
  exit 0
fi
