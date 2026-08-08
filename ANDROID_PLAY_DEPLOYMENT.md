# Android Google Play Deployment — Runbook & Reference

**Repo**: https://github.com/ErBishalBudhathoki/CareNest
**Workflow**: `.github/workflows/flutter_ci_optimized.yml` (id `267597313`)
**Last updated**: Aug 8, 2026

---

## 1. What We Achieved (this release cycle)

- **Android 16 (targetSdk 36) compliance** — edge-to-edge, large-screen support.
- **Versioning fixed end-to-end**: version name is parsed from `pubspec.yaml`, version code is `github.run_number`. No more reliance on the gitignored `android/local.properties` (commit `a8a3f99`).
- **CI-only build + deploy-on-dispatch architecture**: push runs build/test/scan but never deploy; deployment only happens from an explicit `workflow_dispatch`.
- **Secure credential handling**: keystore, signing config, `.env`, `google-services.json`, and the Play service key are passed as GitHub Actions secrets and written/cleaned on every run (never committed).
- **Play Console release note limit honored** (500 chars max) — trimmed note in commit `0226d94`.
- **Successfully deployed**:
  - Internal track: `4.4.0` / code `155` (run `31204671313`)
  - Production track: `4.4.0` / code `158` (run `31245734729`) — live and under review.

### Key commits this cycle
```
0226d94 fix: trim release note to under 500 chars for Play Console limit
ba7cf16 chore(release): bump to 4.4.0+52; fix Android 15/16 compliance
a8a3f99 fix: resolve version from CI env instead of gitignored local.properties
61fec84 fix: mkdir -p before placing AAB in deploy job
e4368c9 fix: replace indented heredoc with printf in key.properties step
f179243 fix: remove secrets context from if conditions in optimized workflow
da348e6 feat: android 16 (targetSdk 36) compliance and deploy-only-on-flag workflow
```

---

## 2. How It Works

```
git push (main/develop)  -->  security-scan -> test -> build-android [debug+release]
                                    ^ no deploy job ever runs on push

workflow_dispatch (manual) -->  build-android -> deploy-android -> notify-failure
```

- **`build-android`** (matrix debug/release): checks out, restores `.env` (`ENV_FILE`), writes
  `google-services.json` for prod + dev, decodes `keystore.jks`, writes `key.properties`,
  builds:
  - release: `flutter build appbundle --release --flavor production --build-number=<run_number>`
  - debug: `flutter build apk --debug --flavor production`
  Uploads AAB as artifact `android-release-build`. Cleans keystore/key.properties afterwards.
- **`deploy-android`** (only on `workflow_dispatch`): installs Fastlane, downloads the AAB,
  places it at `build/app/outputs/bundle/productionRelease/app-production-release.aab`,
  writes the Play service key, then runs:
  - `production`  -> lane `upload_production_aab`
  - anything else (`development`/`internal`) -> lane `upload_internal_aab`
- **Version plumbing**: workflow exports `VERSION_CODE=${{ github.run_number }}` and
  `VERSION_NAME` (parsed from `pubspec.yaml` before `+`). Fastlane `load_flutter_properties`
  prefers these env vars over `local.properties`.
- **Changelog**: Fastlane `ensure_changelog` reads `android/release_notes_<VERSION_NAME>.txt`
  and copies it to `android/fastlane/metadata/android/en-US/changelogs/<VERSION_CODE>.txt`.
- **Concurrency**: `concurrency.group = <workflow>-<ref>` blocks overlapping runs on the same
  branch; a queued dispatch waits for the in-progress run to finish (no auto-cancel).

---

## 3. Deploy Commands (run on a machine with the GitHub token)

The `gh` CLI is not authenticated on the build host; use the REST API with a PAT that has
`actions:write`. The token is stored at `/tmp/opencode/ghtoken` on the host.

### Prerequisites
```bash
TOKEN=$(cat /tmp/opencode/ghtoken)
API=https://api.github.com/repos/ErBishalBudhathoki/CareNest/actions/workflows/267597313/dispatches
```

### Test / debug (internal track — quick feedback)
```bash
curl -s -X POST -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "$API" -d '{"ref":"main","inputs":{"deploy_target":"internal","skip_tests":"true"}}'
```
- Skips the test job, still runs security-scan + builds, then uploads the AAB to the
  **internal testing** track. Version name from pubspec, code = next run_number.
- Debug APK artifact `android-debug-build` is produced on every run.

### Release (production track)
```bash
curl -s -X POST -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "$API" -d '{"ref":"main","inputs":{"deploy_target":"production","skip_tests":"false"}}'
```
- Uploads AAB to the **production** track on Play Console. **Only do this after an internal
  test deploy passes.** No manual approval gate exists — this deploys immediately.

### Watch progress
```bash
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/ErBishalBudhathoki/CareNest/actions/runs?branch=main&per_page=3"
```
- Or open: https://github.com/ErBishalBudhathoki/CareNest/actions

### Before every release
1. Bump `version:` in `pubspec.yaml` (e.g. `4.4.1+53`). Version name must exceed the last
   published version.
2. Update `android/release_notes_<new-version>.txt` — **must be ≤ 500 characters** (Play cap).
3. Commit + push to `main`, wait for the push CI to go green.
4. Dispatch `internal`, then dispatch `production`.

---

## 4. Files & Secrets — What Is Needed and How It Is Stored

### Secrets (GitHub → Settings → Secrets and variables → Actions)
| Secret | Purpose | Where written in CI |
|---|---|---|
| `ANDROID_KEYSTORE_BASE64` | base64 of `keystore.jks` | `android/app/keystore.jks` (deleted after build) |
| `ANDROID_KEYSTORE_PASSWORD` | keystore store password | `android/key.properties` (deleted after build) |
| `ANDROID_KEY_ALIAS` | signing key alias | `android/key.properties` |
| `ANDROID_KEY_PASSWORD` | signing key password | `android/key.properties` |
| `ENV_FILE` | base64 of real `.env` (Firebase, URLs, etc.) | `./.env` |
| `GOOGLE_SERVICES_JSON` | production `google-services.json` | `android/app/google-services.json` |
| `GOOGLE_SERVICES_JSON_DEV` | development `google-services.json` | `android/app/src/development/google-services.json` |
| `GOOGLE_PLAY_API_KEY` | Fastlane service-account JSON (Play Console API access) | `android/fastlane/google-play-service-key.json` (deleted after deploy) |
| `SLACK_WEBHOOK_URL` | failure notifications | consumed by `notify-failure` job |

### On the build host (not in the repo)
| Item | Path | Notes |
|---|---|---|
| GitHub PAT (actions:write) | `/tmp/opencode/ghtoken` | used for dispatch + run polling |
| Git credentials | `/home/opc/.git-credentials` | owned by `opc`; used for `git push` |
| Flutter SDK | `/tmp/opencode/flutter` (v3.44.9) | not needed for deploys — CI builds |

### In the repo (tracked)
- `.github/workflows/flutter_ci_optimized.yml` — the one real deployment workflow
- `pubspec.yaml` — `version: 4.4.0+52` (source of version name)
- `android/fastlane/Fastfile` — lanes + version/changelog logic
- `android/app/build.gradle` — release `minifyEnabled`/`shrinkResources` + signing config

### In the repo (gitignored — force-added, must be handled manually)
- `android/release_notes_<version>.txt` — release note consumed by `ensure_changelog`
  (tracked via `git add -f`; `*.txt` release notes are gitignored)
- `android/local.properties` — NEVER used by CI anymore (version now comes from env)

---

## 5. Handy Fastlane lanes (local, when a machine has the Android SDK)
```bash
cd android
bundle exec fastlane upload_internal_aab    # upload existing AAB to internal
bundle exec fastlane upload_production_aab  # upload existing AAB to production
```
Local builds still need `android/local.properties` + a locally built AAB; the CI path above
is the supported flow.

---

## 6. Gotchas
- Play caps release notes at **500 characters**; longer notes fail the deploy (`31245145968`).
- Version name must strictly increase vs the latest published one (Play enforces it).
- Deploys happen on the **push trigger's** concurrency group — a push run must finish before a
  dispatched run can start.
- The `deploy-android` job only runs when `github.event_name == 'workflow_dispatch'`; pushes
  will never deploy even if the workflow file is edited.
- Production deploys are **not** gated by manual approval in the UI — double-check target.
