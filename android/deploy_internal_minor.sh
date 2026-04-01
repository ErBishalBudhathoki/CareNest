#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AAB_PATH="$PROJECT_ROOT/build/app/outputs/bundle/productionRelease/app-production-release.aab"
PUBSPEC_PATH="$PROJECT_ROOT/pubspec.yaml"
LOCAL_PROPERTIES_PATH="$SCRIPT_DIR/local.properties"
PUBSPEC_BACKUP="$(mktemp)"
LOCAL_PROPERTIES_BACKUP="$(mktemp)"
STEP_COMPLETED="initial"

cleanup() {
  rm -f "$PUBSPEC_BACKUP" "$LOCAL_PROPERTIES_BACKUP"
}

rollback_version() {
  if [[ "$STEP_COMPLETED" != "version_bumped" ]]; then
    return
  fi

  echo ""
  echo "Build/upload failed after version bump. Restoring previous version files..."
  cp "$PUBSPEC_BACKUP" "$PUBSPEC_PATH"
  if [[ -f "$LOCAL_PROPERTIES_BACKUP" ]]; then
    cp "$LOCAL_PROPERTIES_BACKUP" "$LOCAL_PROPERTIES_PATH"
  fi
}

trap 'rollback_version' ERR
trap 'cleanup' EXIT

cp "$PUBSPEC_PATH" "$PUBSPEC_BACKUP"
if [[ -f "$LOCAL_PROPERTIES_PATH" ]]; then
  cp "$LOCAL_PROPERTIES_PATH" "$LOCAL_PROPERTIES_BACKUP"
fi

echo "Step 1/3: Minor version bump"
"$SCRIPT_DIR/update_version.sh" --minor
STEP_COMPLETED="version_bumped"

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

STEP_COMPLETED="uploaded"

echo ""
echo "Done."
echo "Uploaded: $AAB_PATH"
