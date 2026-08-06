#!/bin/bash

# ==============================================================================
# sync_secrets.sh — Sync ONLY the git-ignored (sensitive) project files
# between the VPS and your Mac. Nothing else ever crosses the wire.
#
# Tracked code travels via git (this repo is public). These files CANNOT live
# in git, so they are synced explicitly with rsync + checksums.
#
# Usage:
#   Mac -> VPS : ./scripts/sync_secrets.sh to-vps   <vps-ssh-alias-or-user@host>
#   VPS -> Mac : ./scripts/sync_secrets.sh to-mac   <mac-ssh-alias-or-user@host>
#
# Examples:
#   ./scripts/sync_secrets.sh to-vps "ubuntu@100.64.0.1"
#   ./scripts/sync_secrets.sh to-mac "bishal@192.168.1.50"
#
# SSH keys must already be set up for the target host.
# ==============================================================================

set -euo pipefail

DIRECTION="${1:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target>}"
SSH_TARGET="${2:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target>}"
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# --mkpath needs rsync >= 3.2.3 (macOS ships older rsync) — detect support.
if rsync --help 2>/dev/null | grep -q -- "--mkpath"; then
  MKPATH="--mkpath"
else
  MKPATH=""
fi

# ── Explicit whitelist of crucial git-ignored files (repo-relative) ──────────
REPO_FILES=(
  "android/app/google-services.json"
  "android/app/src/development/google-services.json"
  "android/app/src/production/google-services.json"
  "ios/Runner/GoogleService-Info.plist"
  "android/key.properties"
  "android/fastlane/google-play-service-key.json"
  ".env"
)

# ── debug.keystore lives outside the repo (in ~/.android on both machines) ───
KEYSTORE_REL=".android/debug.keystore"   # relative to $HOME on both sides

# Create the destination directory before copying.
#   local_path : plain path            (e.g. /Users/bishal/projects/invoice/.env)
#   remote_path: ssh-target:path      (e.g. ubuntu@100.64.0.1:/home/coder/projects/invoice/.env)
ensure_parents() {
  local dst="$1"
  if [[ "$dst" == *@*:* ]]; then
    local target="${dst%%:*}" dir="${dst#*:}"
    dir="$(dirname "$dir")"
    ssh "$target" "mkdir -p " 2>/dev/null || true
  else
    mkdir -p "$(dirname "$dst")"
  fi
}

run_rsync() {
  local src="$1" dst="$2"
  echo "  $src"
  echo "    -> $dst"
  ensure_parents "$dst"
  rsync -avz --checksum $MKPATH -e "ssh" "$src" "$dst"
}

echo "Project root : $PROJECT_ROOT"
echo "Direction    : $DIRECTION"
echo "SSH target   : $SSH_TARGET"
echo

case "$DIRECTION" in
  to-vps)
    # Local (Mac) is source; remote (VPS) is destination.
    for f in "${REPO_FILES[@]}"; do
      run_rsync "$PROJECT_ROOT/$f" "${SSH_TARGET}:${PROJECT_ROOT}/$f"
    done
    run_rsync "$HOME/$KEYSTORE_REL" "${SSH_TARGET}:\$HOME/$KEYSTORE_REL"
    ;;
  to-mac)
    # Remote (VPS) is source; local (Mac) is destination.
    for f in "${REPO_FILES[@]}"; do
      run_rsync "${SSH_TARGET}:${PROJECT_ROOT}/$f" "$PROJECT_ROOT/$f"
    done
    run_rsync "${SSH_TARGET}:\$HOME/$KEYSTORE_REL" "$HOME/$KEYSTORE_REL"
    ;;
  *)
    echo "Unknown direction: $DIRECTION (use to-vps or to-mac)" >&2
    exit 1
    ;;
esac

echo
echo "Done. Only the whitelisted files above were touched."
