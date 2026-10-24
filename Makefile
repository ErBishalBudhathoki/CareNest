SHELL := /bin/bash

# ---------------------------------------------------------------------------
# CareNest release entry points
#
# The Flutter app reads its API base URL from a compile-time --dart-define.
# Building without it produces an app that crashes on first request ("base URL
# is empty"). These targets make the env contract explicit and enforce it.
# ---------------------------------------------------------------------------

ENV_FILE := .env
DEV_URL := $(shell grep -E '^DEVELOPMENT_URL=' $(ENV_FILE) 2>/dev/null | head -1 | cut -d= -f2-)
PROD_URL := $(shell grep -E '^PRODUCTION_URL=' $(ENV_FILE) 2>/dev/null | head -1 | cut -d= -f2-)

GCP_PROJECT ?= invoice-660f3
GCP_REGION ?= australia-southeast1
BACKEND_SERVICE_DEV ?= backend-dev
BACKEND_REPO ?= australia-southeast1-docker.pkg.dev/invoice-660f3/backend-repo/backend-dev
BACKEND_SHA := $(shell git -C backend rev-parse --short=7 HEAD 2>/dev/null)

.PHONY: help check-env analyze test release release-apk release-aab \
	release-frontend release-backend-dev

help:
	@echo "make check-env             verify .env has DEVELOPMENT_URL and PRODUCTION_URL"
	@echo "make analyze test          static analysis + unit tests"
	@echo "make release               check, test, build production AAB, deploy backend dev"
	@echo "make release-apk           production APK only"
	@echo "make release-aab           production App Bundle only"
	@echo "make release-backend-dev   build/deploy backend-dev at the current commit"

check-env:
	@test -f $(ENV_FILE) || (echo "Missing $(ENV_FILE); copy .env.example and fill DEVELOPMENT_URL/PRODUCTION_URL"; exit 1)
	@test -n "$(DEV_URL)" || (echo "DEVELOPMENT_URL is empty in $(ENV_FILE)"; exit 1)
	@test -n "$(PROD_URL)" || (echo "PRODUCTION_URL is empty in $(ENV_FILE)"; exit 1)
	@echo "Environment contract OK (URLs present; values not printed)."

analyze:
	flutter analyze

test:
	flutter test
	cd backend && npm test

release-apk: check-env
	flutter pub get
	flutter build apk --release --flavor production \
		--dart-define="PRODUCTION_URL=$(PROD_URL)"

release-aab: check-env
	flutter pub get
	flutter build appbundle --release --flavor production \
		--dart-define="PRODUCTION_URL=$(PROD_URL)"

release-frontend: release-aab

release-backend-dev:
	@test -n "$(BACKEND_SHA)" || (echo "Cannot resolve backend commit"; exit 1)
	@echo "Building backend image $(BACKEND_REPO):$(BACKEND_SHA)"
	cd backend && gcloud builds submit --project $(GCP_PROJECT) \
		--tag $(BACKEND_REPO):$(BACKEND_SHA) .
	gcloud run services update $(BACKEND_SERVICE_DEV) \
		--image $(BACKEND_REPO):$(BACKEND_SHA) \
		--region $(GCP_REGION) --project $(GCP_PROJECT)

# Full local release. Production backend deploys from main via GitHub Actions;
# this target deploys the dev backend so the app and API stay in lock-step.
release: check-env analyze test release-frontend release-backend-dev
	@echo "Release complete: production AAB built, backend-dev deployed at $(BACKEND_SHA)."
