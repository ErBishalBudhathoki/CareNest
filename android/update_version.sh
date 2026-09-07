#!/bin/bash

# Script to update version code and version name for Android app releases
# Flutter pubspec format: MAJOR.MINOR.PATCH+VERSION_CODE  (semver required)
#
# --major:  Bumps MINOR (or rolls MAJOR at .9), resets PATCH to 0, versionCode + 1
# --minor:  Bumps PATCH (or rolls MINOR at .9), versionCode + 1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PUBSPEC_FILE="$SCRIPT_DIR/../pubspec.yaml"
LOCAL_PROPS="$SCRIPT_DIR/local.properties"
CURRENT_DATE=$(date +"%Y.%m.%d")

usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -h, --help                 Display this help message"
  echo "  -m, --major                Increment major version (versionCode + 1)"
  echo "  -n, --minor                Increment minor/patch version (versionCode + 1)"
  echo "  -c, --current-version      Display current version information"
  echo "  -s, --set <version>        Set specific version (e.g. 4.4.4+171)"
  echo "      --set-code <code>      Set specific version code (e.g. 171)"
  echo "      --sync-play            Query Google Play Console and bump past highest uploaded code"
  echo "  -r, --release-notes        Generate release notes template"
  echo ""
  echo "Format: MAJOR.MINOR.PATCH+VERSION_CODE  (e.g. 4.2.0+42)"
  echo "  --major:    4.2.0+42 → 4.3.0+43   (4.9.x+n → 5.0.0+n+1)"
  echo "  --minor:    4.2.0+42 → 4.2.1+43   (4.2.9+n → 4.3.0+n+1)"
  echo "  --set-code: 4.2.0+42 → 4.2.0+171"
  echo "  --set:      4.2.0+42 → 4.4.4+171"
  exit 1
}

# Parse version from pubspec.yaml
# Handles: "4.2.0+42" (standard) and "4.2.42" (legacy — last segment is code)
parse_version() {
  local raw
  raw=$(grep "^version:" "$PUBSPEC_FILE" | sed 's/version: *//')

  if [[ -z "$raw" ]]; then
    echo "Error: No version found in $PUBSPEC_FILE" >&2
    exit 1
  fi

  # Standard format: X.Y.Z+CODE
  if [[ "$raw" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)\+([0-9]+)$ ]]; then
    V_MAJOR="${BASH_REMATCH[1]}"
    V_MINOR="${BASH_REMATCH[2]}"
    V_PATCH="${BASH_REMATCH[3]}"
    V_CODE="${BASH_REMATCH[4]}"
    return
  fi

  # Legacy format: X.Y.CODE (e.g. 4.2.42 where 42 is versionCode, no patch)
  if [[ "$raw" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    local seg3="${BASH_REMATCH[3]}"
    if [[ "$seg3" -gt 9 ]]; then
      # Legacy: 3rd segment is the versionCode
      V_MAJOR="${BASH_REMATCH[1]}"
      V_MINOR="${BASH_REMATCH[2]}"
      V_PATCH=0
      V_CODE="$seg3"
      return
    fi
    # Normal semver without +build: use local.properties for code
    V_MAJOR="${BASH_REMATCH[1]}"
    V_MINOR="${BASH_REMATCH[2]}"
    V_PATCH="${BASH_REMATCH[3]}"
    V_CODE=$(grep "^flutter.versionCode=" "$LOCAL_PROPS" 2>/dev/null | cut -d= -f2)
    V_CODE="${V_CODE:-1}"
    return
  fi

  echo "Error: Cannot parse version '$raw'" >&2
  exit 1
}

# Write version to pubspec.yaml and local.properties
write_version() {
  local major="$1" minor="$2" patch="$3" code="$4"
  local name="${major}.${minor}.${patch}"
  local full="${name}+${code}"

  # pubspec.yaml
  sed -i '' "s/^version:.*/version: $full/" "$PUBSPEC_FILE"

  # local.properties
  if [ -f "$LOCAL_PROPS" ]; then
    if grep -q "^flutter.versionName=" "$LOCAL_PROPS"; then
      sed -i '' "s/^flutter.versionName=.*/flutter.versionName=$name/" "$LOCAL_PROPS"
    else
      echo "flutter.versionName=$name" >> "$LOCAL_PROPS"
    fi
    if grep -q "^flutter.versionCode=" "$LOCAL_PROPS"; then
      sed -i '' "s/^flutter.versionCode=.*/flutter.versionCode=$code/" "$LOCAL_PROPS"
    else
      echo "flutter.versionCode=$code" >> "$LOCAL_PROPS"
    fi
  fi

  echo "✅ Version updated:"
  echo "   pubspec.yaml  → version: $full"
  echo "   versionName   → $name"
  echo "   versionCode   → $code"
  echo "   Play Console  → $code ($CURRENT_DATE)"
}

update_version() {
  local increment_type=$1
  parse_version

  local new_code=$((V_CODE + 1))
  echo "Current: ${V_MAJOR}.${V_MINOR}.${V_PATCH}+${V_CODE}"

  if [ "$increment_type" == "major" ]; then
    # Bump MINOR, reset PATCH. Roll MAJOR at .9
    local new_major=$V_MAJOR
    local new_minor=$((V_MINOR + 1))
    if [ "$new_minor" -gt 9 ]; then
      new_major=$((new_major + 1))
      new_minor=0
    fi
    echo "→ Major bump: ${V_MAJOR}.${V_MINOR}.${V_PATCH} → ${new_major}.${new_minor}.0  (code: $V_CODE → $new_code)"
    write_version "$new_major" "$new_minor" 0 "$new_code"

  elif [ "$increment_type" == "minor" ]; then
    # Bump PATCH. Roll MINOR at .9
    local new_major=$V_MAJOR
    local new_minor=$V_MINOR
    local new_patch=$((V_PATCH + 1))
    if [ "$new_patch" -gt 9 ]; then
      new_minor=$((new_minor + 1))
      new_patch=0
      if [ "$new_minor" -gt 9 ]; then
        new_major=$((new_major + 1))
        new_minor=0
      fi
    fi
    echo "→ Minor bump: ${V_MAJOR}.${V_MINOR}.${V_PATCH} → ${new_major}.${new_minor}.${new_patch}  (code: $V_CODE → $new_code)"
    write_version "$new_major" "$new_minor" "$new_patch" "$new_code"

  else
    echo "Error: Invalid increment type '$increment_type'"
    exit 1
  fi
}

set_explicit_version() {
  local target="$1"
  if [[ "$target" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)\+([0-9]+)$ ]]; then
    local major="${BASH_REMATCH[1]}"
    local minor="${BASH_REMATCH[2]}"
    local patch="${BASH_REMATCH[3]}"
    local code="${BASH_REMATCH[4]}"
    write_version "$major" "$minor" "$patch" "$code"
  else
    echo "Error: Version must match MAJOR.MINOR.PATCH+CODE (e.g. 4.4.4+171)" >&2
    exit 1
  fi
}

set_explicit_code() {
  local new_code="$1"
  if [[ ! "$new_code" =~ ^[0-9]+$ ]]; then
    echo "Error: Version code must be an integer (e.g. 171)" >&2
    exit 1
  fi
  parse_version
  write_version "$V_MAJOR" "$V_MINOR" "$V_PATCH" "$new_code"
}

sync_play_version() {
  parse_version
  echo "🔍 Querying Google Play Console for current version codes on track 'internal'..."
  local play_code
  play_code=$(cd "$SCRIPT_DIR" && fastlane run google_play_track_version_codes package_name:com.bishal.invoice track:internal json_key:fastlane/google-play-service-key.json 2>&1 | grep "Result: \[" | sed -E 's/.*Result: \[([0-9]+)\].*/\1/' || true)
  if [[ -n "$play_code" && "$play_code" =~ ^[0-9]+$ ]]; then
    local next_code=$((play_code + 1))
    echo "Found highest version code on Google Play internal track: $play_code"
    echo "Updating local version code to: $next_code"
    write_version "$V_MAJOR" "$V_MINOR" "$V_PATCH" "$next_code"
  else
    echo "⚠️ Could not parse version code from Google Play automatically." >&2
    exit 1
  fi
}

show_current_version() {
  parse_version
  echo "Current version information:"
  echo "  pubspec.yaml   → version: ${V_MAJOR}.${V_MINOR}.${V_PATCH}+${V_CODE}"
  echo "  versionName    → ${V_MAJOR}.${V_MINOR}.${V_PATCH}"
  echo "  versionCode    → $V_CODE"
  echo "  Play Console   → $V_CODE ($CURRENT_DATE)"
}

generate_release_notes() {
  parse_version
  local release_notes_file="release_notes_${V_CODE}_${CURRENT_DATE}.txt"
  cat > "$release_notes_file" << EOF
# Release Notes - v${V_MAJOR}.${V_MINOR}.${V_PATCH} (Build ${V_CODE}) - ${CURRENT_DATE}

## New Features
-
-

## Bug Fixes
-
-

## Improvements
-
-
EOF
  echo "📝 Release notes template created: $release_notes_file"
}

# Main
if [ $# -eq 0 ]; then
  usage
fi

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)     usage ;;
    -m|--major)    update_version "major" ;;
    -n|--minor)    update_version "minor" ;;
    -c|--current-version) show_current_version ;;
    -s|--set)
      shift
      if [ $# -eq 0 ]; then echo "Error: --set requires a version argument" >&2; exit 1; fi
      set_explicit_version "$1"
      ;;
    --set-code)
      shift
      if [ $# -eq 0 ]; then echo "Error: --set-code requires an integer argument" >&2; exit 1; fi
      set_explicit_code "$1"
      ;;
    --sync-play)   sync_play_version ;;
    -r|--release-notes)   generate_release_notes ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
  shift
done

exit 0