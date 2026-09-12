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
ENV_FILE="$PROJECT_ROOT/.env"

# ── Load .env ──────────────────────────────────────────────────────────────────
# Parse the .env file and export every non-comment, non-empty key=value pair.
# Strips surrounding whitespace from both key and value.
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Error: .env file not found at $ENV_FILE"
  exit 1
fi

while IFS='=' read -r key rest; do
  # Skip comments and blank lines
  [[ "$key" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${key// }" ]] && continue
  key="${key// /}"            # trim key whitespace
  value="${rest#"${rest%%[![:space:]]*}"}"  # ltrim value
  value="${value%"${value##*[![:space:]]}"}"  # rtrim value
  [[ -z "$key" ]] && continue
  export "$key=$value"
done < "$ENV_FILE"

# ── Validate required URL vars ─────────────────────────────────────────────────
if [[ -z "${PRODUCTION_URL:-}" ]]; then
  echo "Error: PRODUCTION_URL is not set in $ENV_FILE"
  exit 1
fi
if [[ -z "${DEVELOPMENT_URL:-}" ]]; then
  echo "Error: DEVELOPMENT_URL is not set in $ENV_FILE"
  exit 1
fi

# Ensure URLs end with /api/ (normalise trailing slash first, then append api/)
normalize_api_url() {
  local url="${1%/}"   # strip trailing slash
  if [[ "$url" != */api ]]; then
    url="$url/api"
  fi
  echo "$url/"
}

PRODUCTION_URL="$(normalize_api_url "$PRODUCTION_URL")"
DEVELOPMENT_URL="$(normalize_api_url "$DEVELOPMENT_URL")"

echo "Resolved PRODUCTION_URL : $PRODUCTION_URL"
echo "Resolved DEVELOPMENT_URL: $DEVELOPMENT_URL"

# ── Version-bump helpers ────────────────────────────────────────────────────────
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

# ── Step 1: Minor version bump ─────────────────────────────────────────────────
echo "Step 1/3: Minor version bump"
"$SCRIPT_DIR/update_version.sh" --minor
STEP_COMPLETED="version_bumped"

# ── Step 2: Build production AAB ───────────────────────────────────────────────
echo ""
echo "Step 2/3: Build production AAB"
(
  cd "$PROJECT_ROOT"
  flutter build appbundle --flavor production -t lib/main_production.dart --release \
    --dart-define=ANDROID_MONTHLY_SUBSCRIPTION_ID=carenest_monthly \
    --dart-define=PRODUCTION_URL="$PRODUCTION_URL" \
    --dart-define=DEVELOPMENT_URL="$DEVELOPMENT_URL"
)

if [[ ! -f "$AAB_PATH" ]]; then
  echo "Error: AAB not found at $AAB_PATH"
  exit 1
fi

# ── Step 3: Upload to Google Play internal testing ─────────────────────────────
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
