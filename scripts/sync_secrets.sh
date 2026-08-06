#!/bin/bash

# ==============================================================================
# sync_secrets.sh — Sync ONLY the git-ignored (sensitive) project files
# between the VPS and your Mac. Nothing else ever crosses the wire.
#
# Tracked code travels via git (this repo is public). These files CANNOT live
# in git, so they are synced explicitly with rsync + checksums.
#
# Usage:
#   ./scripts/sync_secrets.sh to-vps <ssh-target> [ssh-key] [remote-project-root]
#   ./scripts/sync_secrets.sh to-mac <ssh-target> [ssh-key] [remote-project-root]
#
# Examples (VPS = ubuntu@140.238.197.220, key = ~/.ssh/hermes_oci_key):
#   ./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key" "/home/opc/projects/invoice"
#   ./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key" "/home/opc/projects/invoice"
#
# remote-project-root is the repo path on the OTHER machine. Default:
#   /home/opc/projects/invoice  (host path on the Oracle VPS)
# Tilde in ssh-key or project-root is expanded.
#
# The VPS repo is owned by user "opc" with 700/600 perms, so the remote
# rsync runs via sudo (the "ubuntu" user has passwordless sudo).
# ==============================================================================

set -euo pipefail

DIRECTION="${1:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target> [ssh-key] [remote-project-root]}"
SSH_TARGET="${2:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target> [ssh-key] [remote-project-root]}"
SSH_KEY="${3:-}"
REMOTE_ROOT="${4:-/home/opc/projects/invoice}"

# Expand a leading tilde in any path argument (quoted ~ stays literal otherwise).
expand_tilde() {
  local p="$1"
  if [[ "$p" == "~/"* ]]; then echo "${p/#\~/${HOME}}"; else echo "$p"; fi
}
SSH_KEY="$(expand_tilde "$SSH_KEY")"
REMOTE_ROOT="$(expand_tilde "$REMOTE_ROOT")"

LOCAL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# --mkpath needs rsync >= 3.2.3 (macOS ships older rsync) — detect support.
if rsync --help 2>/dev/null | grep -q -- "--mkpath"; then
  MKPATH="--mkpath"
else
  MKPATH=""
fi

# Remote-side rsync runs with sudo to read/write opc-owned files.
RSYNC_PATH="sudo rsync"

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

# Create the destination directory before copying (used when --mkpath is absent).
ensure_parents() {
  local dst="$1"
  if [[ "$dst" == *@*:* ]]; then
    local target="${dst%%:*}" dir="${dst#*:}"
    dir="$(dirname "$dir")"
    ssh_run "$target" "sudo mkdir -p " 2>/dev/null || true
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
    rsync -avz --checksum $MKPATH --rsync-path="$RSYNC_PATH" -e "ssh -i $SSH_KEY" "$src" "$dst"
  else
    rsync -avz --checksum $MKPATH --rsync-path="$RSYNC_PATH" -e "ssh" "$src" "$dst"
  fi
}

echo "Local root  : $LOCAL_ROOT"
echo "Remote root : $REMOTE_ROOT"
echo "Direction   : $DIRECTION"
echo "SSH target  : $SSH_TARGET"
echo "SSH key     : ${SSH_KEY:-<default>}"
echo

case "$DIRECTION" in
  to-vps)
    # Local (Mac) is source; remote (VPS) is destination.
    for f in "${REPO_FILES[@]}"; do
      run_rsync "$LOCAL_ROOT/$f" "${SSH_TARGET}:${REMOTE_ROOT}/$f"
    done
    run_rsync "$HOME/$KEYSTORE_REL" "${SSH_TARGET}:\$HOME/$KEYSTORE_REL"
    ;;
  to-mac)
    # Remote (VPS) is source; local (Mac) is destination.
    for f in "${REPO_FILES[@]}"; do
      run_rsync "${SSH_TARGET}:${REMOTE_ROOT}/$f" "$LOCAL_ROOT/$f"
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
