# Maestro Flows For CareNest

Screenshot generation, smoke navigation and the critical release E2E suite.

**No flow contains a credential.** Every email, password, org code and API base
URL is supplied at run time from `.env.maestro` (gitignored) via the runner.

## Setup (one time)

```bash
cp .env.maestro.example .env.maestro
# fill in locally — never commit this file
./scripts/run_maestro.sh --check      # syntax-check every flow, no device needed
```

`.env.maestro.example` lists every variable the flows reference. The runner
validates that all required variables are populated and refuses to run when a
development `APP_ID` is paired with a production-looking `API_BASE_URL`.

## Critical release suite

| Flow | Covers |
|---|---|
| `00_login.yaml` | Shared login subflow; role credentials passed via `runFlow env` |
| `01_auth_rbac.yaml` | Admin / Employee / Client login, correct dashboard, admin surfaces hidden for non-admins |
| `02_admin_owner_switch.yaml` | Settings -> Owner Tools -> Employee -> back to Admin |
| `03_standard_invoicing.yaml` | Invoice Operations, Client + Employee invoice generation, confirmation + preview, no SIL actions |
| `04_sil_and_ndis_claiming.yaml` | Configuration & Finance -> SIL Management + SIL invoice + NDIS claim export |

Every top-level flow begins with `launchApp: clearState: true` (Maestro 2.5.1
syntax) so no auth state leaks between runs or roles.

## Screenshot / seeding flows

- `carenest_screenshot_tour.yaml` — admin login -> home -> settings.
- `carenest_admin_screenshot_tour.yaml` — admin extension, captures `ASSIGN`.
- `carenest_client_screenshot_tour.yaml` — client login -> home -> settings.
- `carenest_employee_screenshot.yaml` — employee assignment screenshot.
- `create_clients_bulk.yaml`, `create_businesses_bulk.yaml`, `create_employees_bulk.yaml`
  — seed three clients / businesses / employees through the UI.
- `app_store_screenshots*.yaml`, `appstore_screenshots*.yaml` — store asset capture.
- `test_sil_and_invoicing.yaml`, `sil_roster_test.yaml` — SIL / invoicing smoke.
- `test_forgot_password.yaml` — password reset smoke.
- `manager_*`, `worker_*`, `dump_screen.yaml`, `tmp_*` — UI hierarchy probes.

## App IDs

- Android production: `com.bishal.invoice`
- Android development: `com.bishal.invoice.dev`
- iOS production: `com.CareNest.app`

`APP_ID` in `.env.maestro` decides which one Maestro drives. Use the development
flavour for E2E; the production flavour is for release smoke only.

## Usage

```bash
./scripts/run_maestro.sh                          # critical release suite
./scripts/run_maestro.sh 01_auth_rbac.yaml        # one named flow
./scripts/run_maestro.sh --all                    # every flow
./scripts/run_maestro.sh --check                 # syntax check only
```

Runner arguments are forwarded to `maestro test` as `-e KEY=VALUE`. Running a
flow directly with `maestro test` works only if you first export the same
variables into your shell; using the runner is the supported path.

## Notes

- `takeScreenshot` commands are already included in the flows.
- If system permission dialogs appear, grant them manually the first time or adjust the flow in Maestro Studio for your device language and OS version.
- Flows target stable top-level UI labels. The dashboards currently expose no
  `Semantics(identifier:)` test IDs, so ID-based selectors are not yet possible;
  adding them is tracked as a P2 item in the release readiness audit.
- Deeper feature coverage depends on seeded test data and role-specific visibility.
- The employee creation flow starts from `Login` -> `Sign Up`, then toggles
  `Join Existing Organization` and enters `MAESTRO_ORG_CODE`.
- No Maestro flow hardcodes a URL. `API_BASE_URL` is provisioned for future
  deep-link / API health preflight flows and for the runner's dev/prod guard.
