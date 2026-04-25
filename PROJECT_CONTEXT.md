---
title: Project Context
tags:
  - context
  - project
  - codex
aliases:
  - CareNest Project Context
---

# Project Context

> [!info] Always-read summary
> Read this note first for non-trivial work in this repository.

## Product

- Project: `carenest`
- Shape: Flutter mobile app at `/invoice` with companion Node.js backend at `/invoice/backend`
- Primary domains: auth, onboarding, scheduling, invoicing, payroll/billing, admin operations, app store readiness

## Repository Layout

- Local layout is monolithic for convenience.
- GitHub layout is split:
  - frontend has its own GitHub repo
  - backend has its own GitHub repo
- Do not assume shared Git history, shared release flow, or shared CI/CD just because both live under local `/invoice`.

## Tech Stack

- Frontend/mobile: Flutter, Dart, GetX, Riverpod, Firebase
- Backend docs/code: Node.js material under `backend/`
- Verification helpers:
  - `./scripts/codex/flutter-review.sh <paths...>`
  - profile: `codex -p flutter-review`

## Environments

- Backend has two CI/CD tracks:
  - development: Google account `deverbishal331@gmail.com`
  - production: Google account `budhathokib085@gmail.com`
- Development and production use separate MongoDB databases.
- Treat dev and prod config, credentials, deployment targets, and databases as strictly separate.

## Repo Reality

- Worktree may already be dirty. Preserve unrelated changes.
- Do not assume docs are globally current. Start from the smallest relevant doc hub, then drill down.
- Do not invent backend contracts when repo docs or code can answer.
- For deployment/backend/database tasks, explicitly identify dev vs prod before changing anything important.

## Doc Routing

Use these hubs before complex work:

- Frontend/mobile/UI/app flow:
  `[[OBSIDIAN_FRONTEND_MOBILE_DOCS]]`
- Backend/API/server behavior:
  `[[OBSIDIAN_BACKEND_MARKDOWN_INDEX]]`
- Security/privacy/audit/App Store:
  `[[OBSIDIAN_SECURITY_COMPLIANCE_DOCS]]`
- Deployment/operations/config/workflows:
  `[[OBSIDIAN_OPERATIONS_DEPLOYMENT_DOCS]]`
- Planning/PRD/phase tracking/roadmap:
  `[[OBSIDIAN_PRODUCT_PLANNING_DOCS]]`

If routing unclear:

- start at `[[OBSIDIAN_VAULT_HOME]]`
- use `[[OBSIDIAN_MASTER_DOCS_MAP.canvas]]`

## Working Defaults

- Trace first on risky changes.
- Prefer narrow edits.
- Verify touched surface area.
- Cite repo evidence when making decisions.

## Helper

- Fast doc routing helper:
  `bash scripts/codex/recommend-docs.sh <task text or file paths...>`
