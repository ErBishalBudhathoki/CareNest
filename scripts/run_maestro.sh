#!/usr/bin/env bash
# CareNest Maestro E2E runner.
#
# Loads .env.maestro (gitignored), validates that every credential is supplied,
# and forwards the values to Maestro with -e KEY=VALUE. Credential values are
# never printed, echoed or written to logs.
#
# Usage:
#   ./scripts/run_maestro.sh --check                 # syntax-check all flows
#   ./scripts/run_maestro.sh                        # run the critical release suite
#   ./scripts/run_maestro.sh 01_auth_rbac.yaml      # run one or more named flows
#   ./scripts/run_maestro.sh --all                  # run every .maestro/*.yaml
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

ENV_FILE="${MAESTRO_ENV_FILE:-$ROOT/.env.maestro}"
EXAMPLE="$ROOT/.env.maestro.example"
FLOWS_DIR="$ROOT/.maestro"

REQUIRED_VARS=(
  APP_ID
  MAESTRO_ADMIN_USER
  MAESTRO_ADMIN_PASS
  MAESTRO_EMP_USER
  MAESTRO_EMP_PASS
  MAESTRO_CLIENT_USER
  MAESTRO_CLIENT_PASS
  API_BASE_URL
)

OPTIONAL_VARS=(
  MAESTRO_ORG_CODE
  MAESTRO_SEED_CLIENT_1 MAESTRO_SEED_CLIENT_2 MAESTRO_SEED_CLIENT_3
  MAESTRO_SEED_BUSINESS_1 MAESTRO_SEED_BUSINESS_2 MAESTRO_SEED_BUSINESS_3
  MAESTRO_SEED_EMPLOYEE_2 MAESTRO_SEED_EMPLOYEE_3
)

if [[ ! -f "$ENV_FILE" ]]; then
  echo "ERROR: missing $ENV_FILE" >&2
  echo "       cp $EXAMPLE $ENV_FILE and fill in local test credentials." >&2
  exit 1
fi

# Export without ever echoing file contents.
set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

missing=0
for key in "${REQUIRED_VARS[@]}"; do
  if [[ -z "${!key:-}" ]]; then
    echo "ERROR: $key is empty in $ENV_FILE" >&2
    missing=1
  fi
done
if (( missing )); then exit 1; fi

# Fail closed when the app under test and the API target disagree about the
# environment (a dev app pointed at the prod API is a data-integrity incident).
if [[ "${APP_ID}" == *.dev && "${API_BASE_URL}" == *prod* ]]; then
  echo "ERROR: APP_ID is a development build but API_BASE_URL looks like production." >&2
  exit 1
fi

# Build -e args. Values are passed as argv, never interpolated into a shell
# string or written to disk.
env_args=()
for key in "${REQUIRED_VARS[@]}" "${OPTIONAL_VARS[@]}"; do
  value="${!key:-}"
  [[ -n "$value" ]] && env_args+=(-e "$key=$value")
done

CRITICAL_FLOWS=(
  01_auth_rbac.yaml
  02_admin_owner_switch.yaml
  03_standard_invoicing.yaml
  04_sil_and_ndis_claiming.yaml
)

mode="critical"
targets=()
for arg in "$@"; do
  case "$arg" in
    --check) mode="check" ;;
    --all)   mode="all" ;;
    *)       targets+=("$arg") ;;
  esac
done

if (( ${#targets[@]} > 0 )); then
  flows=()
  for t in "${targets[@]}"; do
    [[ "$t" == *.yaml ]] || t="$t.yaml"
    [[ -f "$FLOWS_DIR/$t" ]] || { echo "ERROR: no such flow: $t" >&2; exit 1; }
    flows+=("$FLOWS_DIR/$t")
  done
elif [[ "$mode" == "all" ]]; then
  flows=()
  while IFS= read -r -d '' f; do flows+=("$f"); done \
    < <(find "$FLOWS_DIR" -maxdepth 1 -name '*.yaml' -print0)
else
  flows=()
  for f in "${CRITICAL_FLOWS[@]}"; do flows+=("$FLOWS_DIR/$f"); done
fi

if [[ "$mode" == "check" ]]; then
  for f in "${flows[@]}"; do
    echo "checking $(basename "$f")"
    maestro check-syntax "$f"
  done
  echo "syntax check complete (${#flows[@]} flows)"
  exit 0
fi

echo "running ${#flows[@]} Maestro flow(s) with ${#env_args[@]} env overrides"
maestro test "${env_args[@]}" "${flows[@]}"
