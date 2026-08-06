#!/bin/bash

# ==============================================================================
# sync_secrets.sh — Sync ONLY the git-ignored (sensitive) project files
# between the VPS and your Mac. Nothing else ever crosses the wire.
#
# Tracked code travels via git (this repo is public). These files CANNOT live
# in git, so they are synced explicitly with rsync + checksums.
#
# Usage:
#   Mac -> VPS : ./scripts/sync_secrets.sh to-vps   <ssh-target> [ssh-key]
#   VPS -> Mac : ./scripts/sync_secrets.sh to-mac   <ssh-target> [ssh-key]
#
# Examples:
#   ./scripts/sync_secrets.sh to-vps   "ubuntu@100.64.0.1"
#   ./scripts/sync_secrets.sh to-mac   "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
#
# ssh-key is optional: use it when the host requires a specific identity file
# (e.g. Oracle OCI: -i ~/.ssh/hermes_oci_key).
# ==============================================================================

set -euo pipefail

DIRECTION="${1:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target> [ssh-key]}"
SSH_TARGET="${2:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target> [ssh-key]}"
SSH_KEY="${3:-}"
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

if [ -n "$SSH_KEY" ]; then
  SSH_ARGS=(-i "$SSH_KEY")
else
  SSH_ARGS=()
fi

ssh_run() {
  ssh "${SSH_ARGS[@]}" "$@"
}

# Create the destination directory before copying.
#   local_path : plain path            (e.g. /Users/bishal/projects/invoice/.env)
#   remote_path: ssh-target:path      (e.g. ubuntu@140.238.197.220:/home/coder/projects/invoice/.env)
ensure_parents() {
  local dst="$1"
  if [[ "$dst" == *@*:* ]]; then
    local target="${dst%%:*}" dir="${dst#*:}"
    dir="$(dirname "$dir")"
    ssh_run "$target" "mkdir -p " 2>/dev/null || true
  else
    mkdir -p "$(dirname "$dst")"
  fi
}

run_rsync() {
  local src="$1" dst="$2"
  echo "  $src"
  echo "    -> $dst"
  ensure_parents "$dst"
  if [ -n "$SSH_KEY" ]; then
    rsync -avz --checksum $MKPATH -e "ssh -i $SSH_KEY" "$src" "$dst"
  else
    rsync -avz --checksum $MKPATH -e "ssh" "$src" "$dst"
  fi
}

echo "Project root : $PROJECT_ROOT"
echo "Direction    : $DIRECTION"
echo "SSH target   : $SSH_TARGET"
echo "SSH key      : ${SSH_KEY:-<default>}"
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
