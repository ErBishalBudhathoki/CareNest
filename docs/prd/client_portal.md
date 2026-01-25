# Client Portal (Self-Service) PRD

## 1. Overview
The Client Portal is a secure, self-service interface that allows clients to manage their interactions with the organization directly. It empowers clients to view invoices, approve/dispute charges, manage service agreements, and request appointments, reducing administrative burden and improving transparency.

## 2. Business Goals
- **Transparency**: Give clients real-time access to their billing and schedule.
- **Efficiency**: Reduce manual emails/calls for invoice disputes and scheduling.
- **Compliance**: Ensure service agreements and invoice approvals are digitally tracked.

## 3. User Stories
### 3.1 Authentication
- **US-1.1**: As a Client, I want to log in using my registered email and a password so that I can securely access my data.
- **US-1.2**: As a Client, I want to reset my password if I forget it.

### 3.2 Invoice Management
- **US-2.1**: As a Client, I want to view a list of my past and current invoices.
- **US-2.2**: As a Client, I want to see the details of a specific invoice (line items, total).
- **US-2.3**: As a Client, I want to **Approve** a pending invoice to signal it is ready for payment.
- **US-2.4**: As a Client, I want to **Dispute** an invoice with a reason if I believe there is an error.
- **US-2.5**: As a Client, I want to download a PDF version of the invoice.

### 3.3 Appointments
- **US-3.1**: As a Client, I want to see my upcoming schedule.
- **US-3.2**: As a Client, I want to request a new appointment or change an existing one.

## 4. Design Guidelines (Bauhaus)
- **Philosophy**: Form follows function. Minimalist, geometric, high-contrast.
- **Typography**: Sans-serif, bold headers, clear hierarchy.
- **Color Palette**: Primary colors (Red, Blue, Yellow) with strong black/white contrast.
- **Components**:
  - **Cards**: Flat or subtle shadow, sharp corners (or minimal radius).
  - **Buttons**: Solid primary colors, clear text labels.
  - **Layout**: Grid-based, generous whitespace.

## 5. Technical Architecture

### 5.1 Backend (Node.js/Express)
- **Directory**: `/backend`
- **Authentication**:
  - Extend `login` collection: Add `role: 'client'` and `clientId` reference.
  - Middleware: `verifyClientToken` to ensure clients only access their own data.
- **Endpoints**:
  - `POST /api/auth/client/login`
  - `GET /api/client-portal/invoices`
  - `GET /api/client-portal/invoices/:id`
  - `POST /api/client-portal/invoices/:id/approve`
  - `POST /api/client-portal/invoices/:id/dispute`
  - `GET /api/client-portal/appointments`
  - `POST /api/client-portal/appointments/request`

### 5.2 Frontend (Flutter)
- **Directory**: `lib/app/features/client_portal`
- **Architecture**: MVVM + Riverpod.
- **State Management**:
  - `clientAuthProvider`: Manages login state.
  - `clientInvoiceListProvider`: Fetches and caches invoices.
  - `clientAppointmentProvider`: Manages schedule data.
- **UI Structure**:
  - `ClientLoginView`: Dedicated login screen.
  - `ClientMainView`: Bottom navigation (Invoices, Appointments, Profile).
  - `ClientInvoiceDetailView`: Action buttons for Approve/Dispute.

## 6. Acceptance Criteria
- [ ] Client can log in with valid credentials.
- [ ] Client sees ONLY their own invoices.
- [ ] Approving an invoice updates its status to `APPROVED` in the backend.
- [ ] Disputing an invoice updates status to `DISPUTED` and saves the reason.
- [ ] Appointment list reflects real-time data from the backend.
