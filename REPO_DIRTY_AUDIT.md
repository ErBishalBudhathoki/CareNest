# Repo Dirty-State Audit (Frontend + Backend)

## 1) Scan Metadata
- Scan time: `2026-02-15 17:37:20 AEDT`
- Root repo path: `/Users/bishal/Developer/invoice`
- Backend repo path: `/Users/bishal/Developer/invoice/backend` (separate nested Git repo)
- Root branch/head: `main` @ `ea0c46d`
- Backend branch/head: `dev` @ `9f9d904`

## 2) Current Reality (Right Now)
After scanning both repos, this is the exact current dirty state:

### Root repo
- Dirty files count: `1`
- Dirty files:
  - `M .env.example`

### Backend repo
- Dirty files count: `0`
- Dirty files:
  - none

## 3) Why You Previously Saw “Both Repos Dirty”
I previously captured a full snapshot before cleanup attempts:
- Snapshot time: `2026-02-15 17:07:59 AEDT`
- Snapshot artifact root: `/tmp/invoice_preclean_20260215_170759`

Snapshot counts:
- Root repo: `269` dirty entries
  - `41` modified tracked (`M`)
  - `228` untracked (`??`)
- Backend repo: `83` dirty entries
  - `14` modified tracked (`M`)
  - `69` untracked (`??`)

Top dirty path groups from that snapshot:
- Root: `lib (149)`, `docs (104)`, `.github (9)`, plus a few root files
- Backend: `services (36)`, `routes (20)`, `controllers (17)`, `models (4)`, others

So the reason you saw both dirty earlier is straightforward: both repos had a large amount of uncommitted work (modified tracked files + many new files not added/committed yet).

## 4) File-Level Inventories
Full file-level inventories are saved locally:
- Historical root inventory: `docs/audit/root_dirty_snapshot_20260215_170759.status.txt`
- Historical backend inventory: `docs/audit/backend_dirty_snapshot_20260215_170759.status.txt`
- Current root inventory: `docs/audit/root_dirty_current_20260215_173720.status.txt`
- Current backend inventory: `docs/audit/backend_dirty_current_20260215_173720.status.txt`

Note:
- `docs/` is currently ignored by `.gitignore` (`.gitignore:429`), so these audit artifacts do not appear in Git status.

## 5) Why the Root Repo Is Still Dirty
Only one file is dirty now: `.env.example`.

Reason:
- It has local content updates that were not committed.
- `git diff` shows added environment template keys (e.g., `DEVELOPMENT_URL`, `PRODUCTION_URL`, integration credential placeholders).

## 6) How to Fix Dirty State (Detailed)

## Option A: Keep the current `.env.example` change
Use this if the template updates are intentional.

```bash
cd /Users/bishal/Developer/invoice
git add .env.example
git commit -m "chore(env): update .env.example template keys"
```

Then verify:

```bash
git status --short --branch
git -C backend status --short --branch
```

Expected:
- root clean
- backend clean

## Option B: Discard the current `.env.example` change
Use this if the change is accidental.

```bash
cd /Users/bishal/Developer/invoice
git restore .env.example
```

Then verify:

```bash
git status --short --branch
git -C backend status --short --branch
```

Expected:
- root clean
- backend clean

## Option C: Safe hard-clean process (for future large dirty states)
Use this when both repos are heavily dirty and you want a deterministic baseline.

### Step 1: Snapshot before destructive cleanup
```bash
STAMP=$(date +%Y%m%d_%H%M%S)
BASE="/tmp/invoice_preclean_${STAMP}"
mkdir -p "$BASE/root" "$BASE/backend"

git -C /Users/bishal/Developer/invoice status --porcelain=v1 -uall > "$BASE/root/status.txt"
git -C /Users/bishal/Developer/invoice diff > "$BASE/root/working.diff"
git -C /Users/bishal/Developer/invoice diff --cached > "$BASE/root/index.diff"
git -C /Users/bishal/Developer/invoice ls-files -o --exclude-standard > "$BASE/root/untracked.txt"

git -C /Users/bishal/Developer/invoice/backend status --porcelain=v1 -uall > "$BASE/backend/status.txt"
git -C /Users/bishal/Developer/invoice/backend diff > "$BASE/backend/working.diff"
git -C /Users/bishal/Developer/invoice/backend diff --cached > "$BASE/backend/index.diff"
git -C /Users/bishal/Developer/invoice/backend ls-files -o --exclude-standard > "$BASE/backend/untracked.txt"
```

### Step 2: Hard-clean both repos
```bash
git -C /Users/bishal/Developer/invoice reset --hard
git -C /Users/bishal/Developer/invoice clean -fd

git -C /Users/bishal/Developer/invoice/backend reset --hard
git -C /Users/bishal/Developer/invoice/backend clean -fd
```

### Step 3: Verify clean
```bash
git -C /Users/bishal/Developer/invoice status --short --branch
git -C /Users/bishal/Developer/invoice/backend status --short --branch
```

## 7) Structural Notes That Affect “Dirty” Behavior
- `backend/` is a separate Git repository, so root and backend must be checked/cleaned independently.
- `.gitignore` currently ignores `docs/` and `.env.example` entries, but already tracked files (like `.env.example`) can still show as modified.
- Large feature spikes without frequent commits naturally produce large `??` (untracked) sets and make repos appear unstable.

## 8) Prevention Checklist
- Commit in small increments by feature slice.
- Keep generated artifacts and local audit outputs outside tracked scope or explicitly ignored.
- Run both status checks before/after work:
  - `git -C /Users/bishal/Developer/invoice status --short --branch`
  - `git -C /Users/bishal/Developer/invoice/backend status --short --branch`
- For destructive cleanup, always snapshot first.
