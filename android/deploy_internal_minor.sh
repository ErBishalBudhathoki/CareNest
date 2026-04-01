#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AAB_PATH="$PROJECT_ROOT/build/app/outputs/bundle/productionRelease/app-production-release.aab"

echo "Step 1/3: Minor version bump"
"$SCRIPT_DIR/update_version.sh" --minor

echo ""
echo "Step 2/3: Build production AAB"
(
  cd "$PROJECT_ROOT"
  flutter build appbundle --flavor production -t lib/main_production.dart --release
)

if [[ ! -f "$AAB_PATH" ]]; then
  echo "Error: AAB not found at $AAB_PATH"
  exit 1
fi

echo ""
echo "Step 3/3: Upload to Google Play internal testing"
(
  cd "$SCRIPT_DIR"
  fastlane android upload_internal_aab
)

echo ""
echo "Done."
echo "Uploaded: $AAB_PATH"
