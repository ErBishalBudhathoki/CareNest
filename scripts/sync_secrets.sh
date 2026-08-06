#!/bin/bash

# ==============================================================================
# sync_secrets.sh — Sync ONLY git-ignored project files between the VPS and
# your Mac. Nothing else ever crosses the wire.
#
# Tracked code travels via git (this repo is public). These files CANNOT live
# in git, so they are synced explicitly with rsync + checksums.
#
# Two categories are synced:
#   1. SECRETS  — keys/credentials required to build & run the app.
#   2. DEV NOTES — gitignored scratch files (docs, *.py helpers) so both
#      machines share the same working context.
#
# Usage:
#   ./scripts/sync_secrets.sh to-vps <ssh-target> [ssh-key] [remote-project-root] [remote-keystore]
#   ./scripts/sync_secrets.sh to-mac <ssh-target> [ssh-key] [remote-project-root] [remote-keystore]
#
# Examples (VPS = ubuntu@140.238.197.220, key = ~/.ssh/hermes_oci_key):
#   ./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
#   ./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
#
# remote-project-root: repo path on the OTHER machine (default /home/opc/projects/invoice).
# remote-keystore:     debug.keystore path on the OTHER machine
#                      (default /home/opc/projects/.android/debug.keystore).
# Tilde in any path argument is expanded.
#
# The VPS repo is owned by user "opc" with 700/600 perms, so the remote
# rsync runs via sudo (the "ubuntu" user has passwordless sudo).
# ==============================================================================

set -euo pipefail

DIRECTION="${1:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target> [ssh-key] [remote-project-root] [remote-keystore]}"
SSH_TARGET="${2:?Usage: sync_secrets.sh (to-vps|to-mac) <ssh-target> [ssh-key] [remote-project-root] [remote-keystore]}"
SSH_KEY="${3:-}"
REMOTE_ROOT="${4:-/home/opc/projects/invoice}"
REMOTE_KEYSTORE="${5:-/home/opc/projects/.android/debug.keystore}"

# Expand a leading tilde in any path argument (quoted ~ stays literal otherwise).
expand_tilde() {
  local p="$1"
  if [[ "$p" == "~/"* ]]; then echo "${p/#\~/${HOME}}"; else echo "$p"; fi
}
SSH_KEY="$(expand_tilde "$SSH_KEY")"
REMOTE_ROOT="$(expand_tilde "$REMOTE_ROOT")"
REMOTE_KEYSTORE="$(expand_tilde "$REMOTE_KEYSTORE")"

LOCAL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_KEYSTORE="$HOME/.android/debug.keystore"

# --mkpath needs rsync >= 3.2.3 (macOS ships older rsync) — detect support.
if rsync --help 2>/dev/null | grep -q -- "--mkpath"; then
  MKPATH="--mkpath"
else
  MKPATH=""
fi

# Remote-side rsync runs with sudo to read/write opc-owned files.
RSYNC_PATH="sudo rsync"

# ── Whitelist of crucial git-ignored files (repo-relative) ──────────────────
# Category 1: SECRETS — required to build & run the app.
SECRET_FILES=(
  "android/app/google-services.json"
  "android/app/src/development/google-services.json"
  "android/app/src/production/google-services.json"
  "ios/Runner/GoogleService-Info.plist"
  "android/key.properties"
  "android/fastlane/google-play-service-key.json"
  ".env"
)

# Category 2: DEV NOTES — gitignored scratch files shared between machines.
DEV_FILES=(
  "TRACKING.md"
  "task.md"
  "walkthrough.md"
  "state_logic.txt"
  "vm_logic.txt"
  "riverpod_3_migration_plan.md"
  "AGENTS.md"
  "TODO.md"
)

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
    ssh_run "$target" "sudo mkdir -p \"$dir\"" 2>/dev/null || true
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

# List root-level *.py scratch scripts on the SOURCE side (local or remote).
list_py_scripts() {
  local side="$1"
  if [[ "$side" == "remote" ]]; then
    ssh_run "$SSH_TARGET" "ls -1 $REMOTE_ROOT/*.py 2>/dev/null || true"
  else
    ls -1 "$LOCAL_ROOT"/*.py 2>/dev/null || true
  fi
}

echo "Local root     : $LOCAL_ROOT"
echo "Remote root    : $REMOTE_ROOT"
echo "Local keystore : $LOCAL_KEYSTORE"
echo "Remote keystore: $REMOTE_KEYSTORE"
echo "Direction      : $DIRECTION"
echo "SSH target     : $SSH_TARGET"
echo "SSH key        : ${SSH_KEY:-<default>}"
echo

case "$DIRECTION" in
  to-vps)
    # Local (Mac) is source; remote (VPS) is destination.
    for f in "${SECRET_FILES[@]}" "${DEV_FILES[@]}"; do
      [ -f "$LOCAL_ROOT/$f" ] && run_rsync "$LOCAL_ROOT/$f" "${SSH_TARGET}:${REMOTE_ROOT}/$f"
    done
    for py in $(list_py_scripts local); do
      run_rsync "$py" "${SSH_TARGET}:${REMOTE_ROOT}/$(basename "$py")"
    done
    run_rsync "$LOCAL_KEYSTORE" "${SSH_TARGET}:${REMOTE_KEYSTORE}"
    ;;
  to-mac)
    # Remote (VPS) is source; local (Mac) is destination.
    for f in "${SECRET_FILES[@]}" "${DEV_FILES[@]}"; do
      run_rsync "${SSH_TARGET}:${REMOTE_ROOT}/$f" "$LOCAL_ROOT/$f"
    done
    for py in $(list_py_scripts remote); do
      run_rsync "${SSH_TARGET}:$py" "$LOCAL_ROOT/$(basename "$py")"
    done
    run_rsync "${SSH_TARGET}:${REMOTE_KEYSTORE}" "$LOCAL_KEYSTORE"
    ;;
  *)
    echo "Unknown direction: $DIRECTION (use to-vps or to-mac)" >&2
    exit 1
    ;;
esac

echo
echo "Done. Only the whitelisted files above were touched."
