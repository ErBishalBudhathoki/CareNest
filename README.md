# CareNest — NDIS & Disability Support Management Platform

CareNest is a comprehensive care management and invoicing platform built with Flutter and Node.js. It serves NDIS and disability support providers with multi-tenant architecture, role-based access control, and end-to-end workflows spanning invoicing, scheduling, time tracking, payroll, care intelligence, and compliance.

The app is available on the [Google Play Store](https://play.google.com/store/apps/details?id=com.bishal.invoice&pcampaignid=web_share).

## Features

### Invoicing & Payments
- Invoice generation with automatic numbering and NDIS pricing rules
- PDF generation, download, email, and sharing
- Credit notes and multiple invoice types
- Stripe, PayPal, and Square payment integration
- Xero, MYOB, and QuickBooks accounting integration

### Scheduling & Time Tracking
- Shift creation, assignment, and roster templates
- Clock in/out with geofencing verification
- Timesheet management with conflict detection
- Calendar sync (Google Calendar, Microsoft Outlook)

### Client & Business Management
- Client profiles, appointment scheduling, and service history
- Business and organization management
- Multi-tenant data isolation

### Payroll & Financial Intelligence
- Payroll processing with earnings dashboards
- Expense tracking and mileage reimbursement
- Revenue forecasting, cash flow prediction, and budget management
- Anomaly detection and financial analytics

### Care Intelligence
- Risk assessments and care plan builder
- Incident management and medication tracking
- Health monitoring dashboards and outcome tracking
- Behavior support planning

### Workforce Management
- Employee profiles with document storage
- Leave management with balance tracking
- Training modules and compliance checklists
- Certification tracking

### Communication & Voice
- In-app messaging and push notifications
- Voice assistant with speech-to-text commands
- Emergency broadcasts

### Security & Compliance
- Firebase App Check (Play Integrity / App Attest)
- JWT with key rotation and Argon2 password hashing
- Role-based access control (admin, employee, worker, client)
- Rate limiting, audit logging, encrypted storage

### Platform Capabilities
- Offline support with background sync
- OCR text recognition via Google ML Kit
- Deep linking with universal links and app links
- Real-time location tracking and geofencing

## Benefits

- **All-in-one platform** — Replace fragmented tools with a single solution covering invoicing, scheduling, care management, payroll, and compliance
- **NDIS-ready** — Built-in NDIS price cap enforcement, support item catalog, and SCHADS award rate integration
- **Multi-tenant by design** — Each organization's data is fully isolated with independent user management
- **Offline-first** — Field staff can work without connectivity; data syncs automatically when back online
- **Real-time collaboration** — Instant updates across the team with WebSocket-powered live tracking and messaging
- **Enterprise security** — App Check, encrypted storage, JWT rotation, and granular role-based permissions
- **Cross-platform** — Single codebase targeting Android, iOS, and Web from one Flutter project

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Flutter (Dart), Riverpod + Provider, GetIt |
| Backend | Node.js, Express, MongoDB (Mongoose), Redis |
| Auth | Firebase Auth, JWT with key rotation, Argon2 |
| Real-time | Socket.IO, Firebase Cloud Messaging |
| Monitoring | Prometheus, Grafana, Loki, Alertmanager |
| Payments | Stripe, PayPal, Square |
| Integrations | Xero, MYOB, QuickBooks, Google Calendar, Outlook, Slack |

## Getting Started

### Prerequisites

- **Flutter SDK** >= 3.0 ([install guide](https://docs.flutter.dev/get-started/install))
- **Node.js** >= 18 (for the backend)
- **MongoDB** instance (local or [Atlas](https://www.mongodb.com/atlas))
- **Firebase project** with Authentication, Firestore, and Cloud Messaging enabled
- **Docker** (optional, for the monitoring stack)

### Environment Setup

```bash
# Clone the repository
git clone https://github.com/ErBishalBudhathoki/CareNest.git
cd CareNest

# Copy and configure environment variables
cp .env.example .env
# Edit .env with your Firebase, MongoDB, and provider credentials
```

### Flutter App

```bash
# Install dependencies
flutter pub get

# Generate localization, JSON serialization, and freezed code
dart run build_runner build --delete-conflicting-outputs

# Run on a connected device or emulator
flutter run

# Run with a specific flavor (dev or prod)
flutter run --dart-define=FLUTTER_APP_FLAVOR=dev
```

### Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release --no-wasm-dry-run
```

### Backend

The backend is maintained in a separate repository. Clone and follow its README for detailed setup.

```bash
git clone https://github.com/ErBishalBudhathoki/carenest_backend.git
cd carenest_backend
cp .env.example .env
npm install
npm run dev
```

### Monitoring Stack (Docker)

```bash
cd docker
docker compose -f docker-compose.monitoring.yml up -d
# Starts Prometheus, Grafana, Loki, Promtail, cAdvisor, Node Exporter, and Alertmanager
```

### Running Tests

```bash
# Unit and widget tests
flutter test

# With coverage
flutter test --coverage

# Update golden files
flutter test --update-goldens

# Integration tests
flutter drive --target=test_driver/integration_test.dart
```

## Project Structure

```
lib/
├── main.dart                    # App entry point (Firebase init, routing, deep links)
├── app/
│   ├── core/                    # Cross-cutting utilities, providers, services, networking
│   ├── di/                      # Dependency injection (GetIt service locator)
│   ├── features/                # Feature modules (feature-first architecture)
│   │   ├── invoice/             # Invoice CRUD, generation, PDF, email
│   │   ├── scheduling/          # Shift and roster management
│   │   ├── timesheet/           # Timesheet entry and approval
│   │   ├── payroll/             # Payroll processing and dashboards
│   │   ├── care_intelligence/   # Risk assessment, care plans, incidents
│   │   ├── analytics/           # Analytics and reporting dashboards
│   │   ├── financial_intelligence/  # Forecasting, cash flow, budgets
│   │   ├── communication/       # In-app messaging
│   │   ├── voice_assistant/     # Speech-to-text commands
│   │   ├── training_compliance/ # Training modules and certifications
│   │   ├── leave/               # Leave requests and balances
│   │   ├── expenses/            # Expense tracking and reimbursement
│   │   ├── pricing/             # NDIS pricing and SCHADS rates
│   │   ├── ocr/                 # Text recognition from images
│   │   ├── offline/             # Offline data and sync management
│   │   └── ...                  # 40+ additional feature modules
│   ├── routes/                  # Named route definitions
│   └── shared/                  # Constants, themes, shared widgets
├── l10n/                        # ARB localization source files
└── generated/                   # Auto-generated localization code
```

## Documentation

- **Architecture**: See `docs/` for architecture decision records and system design
- **API Docs**: See the backend repository for Swagger/OpenAPI documentation
- **Deployment**: See `DEPLOYMENT_WORKFLOWS_STATUS.md` for CI/CD pipeline details

## License

This project is proprietary. All rights reserved.
