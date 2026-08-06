# Multi-Machine Development Workflow — VPS ↔ Mac

How to work on **CareNest** from two machines (Oracle VPS + macOS) without ever
fighting over file state. The core rule is simple:

> **Tracked code moves through git. Everything else moves through `sync_secrets.sh`.**

Never mix the two. Never sync build artifacts. Never git-add a secret.

---

## 1. The two channels

| Channel | What it moves | Command | When |
|---------|---------------|---------|------|
| **git** | All tracked source code (`lib/`, `test/`, `android/` code, `pubspec.yaml`, committed docs, etc.) | `git push` / `git pull` | Every code change |
| **sync script** | Everything git deliberately ignores (secrets + dev notes) | `./scripts/sync_secrets.sh to-…` | After secret/note changes; before switching machines |

The GitHub repo is **public**, so secrets can never go through git. The sync
script is the only bridge for them — and it is a strict **whitelist** (only the
files listed are ever touched).

---

## 2. Machine topology

```
┌─────────────┐  git push/pull  ┌──────────────┐  ssh + rsync  ┌──────────────┐
│     Mac     │ ──────────────▶ │  GitHub (public)  │ ──────────▶ │   Oracle VPS   │
│  ~/Developer/invoice  │                 │  repo  │              │ /home/opc/projects/invoice │
└─────────────┘ ◀────────────── └──────────────┘ ◀────────────── └──────────────┘
```

- **Mac repo:** `/Users/bishal/Developer/invoice`
- **VPS repo (host filesystem):** `/home/opc/projects/invoice` (owned by `opc`, 700/600)
- **VPS repo (dev container view):** `/home/coder/projects/invoice`
- **SSH from Mac:** `ubuntu@140.238.197.220` with key `~/.ssh/hermes_oci_key`
- Remote rsync runs via `sudo` (the `ubuntu` user has passwordless sudo) because
  the files are owned by `opc`.

---

## 3. What `sync_secrets.sh` syncs

One script, run on **either** machine, direction-controlled by the first argument.
It syncs **only** these git-ignored files:

### 3a. Secrets (must be identical on both machines)

| File | Purpose |
|------|---------|
| `android/app/google-services.json` | Firebase config (release flavor) |
| `android/app/src/development/google-services.json` | Firebase config (dev flavor) |
| `android/app/src/production/google-services.json` | Firebase config (prod flavor) |
| `ios/Runner/GoogleService-Info.plist` | iOS Firebase config |
| `android/key.properties` | Signing keystore credentials |
| `android/fastlane/google-play-service-key.json` | Play Store service account |
| `.env` | Runtime env variables |
| `~/.android/debug.keystore` | Shared debug signing key (App Check relies on its SHA-1) |

> **Why the debug keystore matters:** Firebase App Check allow-lists the debug
> SHA-1 fingerprint `B3:58:2D:EA:…`. If either machine uses a *different* debug
> keystore, App Check fails on that machine. The sync keeps both identical.

### 3b. Dev notes (gitignored scratch files)

| File | Purpose |
|------|---------|
| `TRACKING.md`, `task.md`, `TODO.md`, `AGENTS.md` | Current task context |
| `walkthrough.md` | Step-by-step walkthrough notes |
| `state_logic.txt`, `vm_logic.txt` | Architecture/state analysis dumps |
| `riverpod_3_migration_plan.md` | Migration plan |
| `*.py` (root level, all ~78) | One-off refactor/scratch scripts |

### 3c. Explicitly NOT synced (regenerated locally — never sync these)

`build/`, `.dart_tool/`, `.pub-cache/`, `ios/Pods/`, `.gradle/`,
`.kotlin/`, `.idea/`, `.vscode/`, `.DS_Store`, screenshots, PDFs.
These are machine-specific caches/artifacts; copying them causes corruption.

---

## 4. Using the sync script

### Syntax

```bash
./scripts/sync_secrets.sh to-vps <ssh-target> [ssh-key] [remote-project-root] [remote-keystore]
./scripts/sync_secrets.sh to-mac <ssh-target> [ssh-key] [remote-project-root] [remote-keystore]
```

### The two realistic commands

From the **Mac**, pulling VPS state down (i.e., "make my Mac match the VPS"):

```bash
git fetch origin && git reset --hard origin/main
./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
```

From the **Mac**, pushing local state up to the VPS:

```bash
git push origin main
./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
```

> The last two arguments have sensible defaults (`/home/opc/projects/invoice`
> and `/home/opc/projects/.android/debug.keystore`) — omit them.

---

## 5. Day-to-day playbook

### Scenario A — You worked on the VPS, now switching to the Mac

1. On the VPS: `git add -A && git commit` (code), and
   `./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"`
   to push any secret/note changes out to the VPS.
2. On the Mac:
   ```bash
   git fetch origin && git reset --hard origin/main     # code
   ./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
   ```
3. Done — the Mac is an exact replica.

### Scenario B — You worked on the Mac, now switching to the VPS

1. On the Mac: `git add -A && git commit && git push`.
2. On the Mac:
   ```bash
   ./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
   ```
3. On the VPS (inside the container):
   ```bash
   git fetch origin && git reset --hard origin/main
   ./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
   ```
   (The direction here is from the VPS's point of view: it pulls *from* the Mac.)

### Scenario C — Changing a secret (e.g., new Firebase config)

Never commit it. Save it on one machine, then immediately sync:

```bash
./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
# or, from the other side:
./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
```

Then verify on both machines that the file content matches (e.g. `diff` or the
checksum printed by rsync).

---

## 6. Safety rules

1. **Never `git add -f` a secret.** A pre-commit hook
   (`scripts/check_sensitive_files.sh`) scans staged files and blocks secret
   content — but you must still be careful, since `sync_secrets.sh` itself is
   force-added (because `scripts/` is git-ignored). Keep the script a pure
   whitelist and never hard-code a secret *value* in it.
2. **Never sync `build/` or caches.** Always `flutter clean` + rebuild on the
   target machine instead.
3. **Always run `git reset --hard origin/main` on arrival**, not `git pull`, so
   the arrival machine's working tree exactly matches the source of truth. (Only
   if you have no local uncommitted changes you care about.)
4. **The VPS is the canonical secret store** (its files are opc-owned and
   correct). When in doubt, sync `to-mac` from the VPS.

---

## 7. Troubleshooting

| Symptom | Fix |
|---------|-----|
| `Permission denied (13)` on `/home/opc/…` | This is expected for the `ubuntu` user; the script uses `sudo rsync` automatically. If you see it in the plain `ls` for `*.py`, it means the dir perms changed — re-check `ls -ld /home/opc/projects/invoice`. |
| `No such file or directory` for `/home/coder/...` | You used the container path. The script defaults to the host path `/home/opc/projects/invoice` — leave the default. |
| Keystore `link_stat … failed` | The remote keystore path is wrong; pass the 5th arg, e.g. `/home/opc/projects/.android/debug.keystore`. |
| SSH `Permission denied (publickey)` | Key not found. Use `~/.ssh/hermes_oci_key` (the script expands the tilde). |
| rsync `--mkpath` error | macOS ships old rsync; the script auto-detects and drops the flag. |
| App Check fails on one machine only | Debug keystore mismatch — re-run the sync so `~/.android/debug.keystore` matches. |

---

## 8. Reference — the two commands to remember

```bash
# From Mac, pull VPS state down:
git fetch origin && git reset --hard origin/main
./scripts/sync_secrets.sh to-mac "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"

# From Mac, push Mac state up:
git push origin main
./scripts/sync_secrets.sh to-vps "ubuntu@140.238.197.220" "~/.ssh/hermes_oci_key"
```
