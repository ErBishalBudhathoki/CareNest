# Maestro Flows For CareNest

These flows are a starting point for screenshot generation and smoke navigation.

## Files

- `carenest_screenshot_tour.yaml`
  Admin/employee login -> home -> settings screenshot tour.
- `carenest_admin_screenshot_tour.yaml`
  Admin-only extension that also captures the `ASSIGN` tab.
- `carenest_client_screenshot_tour.yaml`
  Client login -> home -> settings screenshot tour.
- `create_clients_bulk.yaml`
  Logs in as the admin and creates three clients using the Add Client form.
- `create_businesses_bulk.yaml`
  Logs in as the admin and creates three businesses using the Add Business form.
- `create_employees_bulk.yaml`
  Creates three employee accounts through the signup UI and joins the current organization with an org code.

## App IDs

- Android production: `com.bishal.invoice`
- Android development: `com.bishal.invoice.dev`
- iOS production: `com.CareNest.app`

## Default Credentials In These Files

These flows are prefilled for your current dev screenshot setup:

- App ID: `com.bishal.invoice.dev`
- Admin/employee email: `deverbishal331@gmail.com`
- Client email: `bishalkc331@gmail.com`

You can still override any of these with Maestro `-e` flags if needed.

## Suggested Usage

Run the common tour first, then the admin tour if the account has admin access.

Typical commands:

```bash
maestro test .maestro/carenest_screenshot_tour.yaml
maestro test .maestro/carenest_admin_screenshot_tour.yaml
maestro test .maestro/carenest_client_screenshot_tour.yaml
maestro test .maestro/create_clients_bulk.yaml
maestro test .maestro/create_businesses_bulk.yaml
maestro test .maestro/create_employees_bulk.yaml -e ORG_CODE=YOUR_ORG_CODE
```

## Notes

- `takeScreenshot` commands are already included in the flows.
- If system permission dialogs appear, grant them manually the first time or adjust the flow in Maestro Studio for your device language and OS version.
- These flows intentionally target stable, top-level UI labels first. Deeper feature coverage usually depends on seeded test data and role-specific visibility.
- If you want a fuller screenshot pack later, the next step is to add seeded demo data and build dedicated flows per feature area.
- The employee creation flow starts from `Login` -> `Sign Up`, then toggles `Join Existing Organization` and enters `ORG_CODE`.
