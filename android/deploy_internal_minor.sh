#!/bin/bash

# -E (errtrace) matters: the build runs inside a subshell, and without it the
# ERR trap is not inherited there, so a failed build left the version bumped
# instead of rolling it back.
set -Eeuo pipefail

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
echo "Step 1/4: Minor version bump"
"$SCRIPT_DIR/update_version.sh" --minor
STEP_COMPLETED="version_bumped"

# ── Step 2: Build production AAB for Internal Testing ──────────────────────────
# Google Play Console requires the production package ID (com.bishal.invoice),
# so we build with --flavor production -t lib/main_production.dart.
# However, internal testing MUST ALWAYS communicate exclusively with the dev backend!
# We therefore inject DEVELOPMENT_URL into both PRODUCTION_URL and DEVELOPMENT_URL.
echo ""
echo "Step 2/4: Build AAB for Internal Testing (connecting to dev backend: $DEVELOPMENT_URL)"
(
  cd "$PROJECT_ROOT"

  # Resolve dependencies explicitly first. `update_version.sh` just rewrote
  # pubspec.yaml, so `flutter build` would otherwise run its own implicit
  # pub get -- which regenerates GeneratedPluginRegistrant.java with the
  # dev-only plugins (patrol, integration_test) still in it. Doing it here
  # means the build sees an already-satisfied pubspec and will not repeat it,
  # so the strip below survives.
  flutter pub get

  # Then drop those dev-only registrations. Left in place they fail the release
  # compile with "package pl.leancode.patrol does not exist", because neither
  # plugin ships native code for a release build.
  python3 android/strip_dev_plugins.py

  flutter build appbundle --flavor production -t lib/main_production.dart --release \
    --dart-define=ANDROID_MONTHLY_SUBSCRIPTION_ID=carenest_monthly \
    --dart-define=PRODUCTION_URL="$DEVELOPMENT_URL" \
    --dart-define=DEVELOPMENT_URL="$DEVELOPMENT_URL" \
    --dart-define=ENABLE_DEV_SUBSCRIPTION_RESET=true
)

if [[ ! -f "$AAB_PATH" ]]; then
  echo "Error: AAB not found at $AAB_PATH"
  exit 1
fi

# ── Step 3: Upload to Google Play internal testing ─────────────────────────────
echo ""
echo "Step 3/4: Upload to Google Play internal testing"
(
  cd "$SCRIPT_DIR"
  fastlane android upload_internal_aab
)

STEP_COMPLETED="uploaded"

echo ""
echo "Done."
echo "Uploaded: $AAB_PATH"
