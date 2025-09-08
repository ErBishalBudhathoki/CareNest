# CareNest - Invoice Management App

CareNest is a comprehensive invoice management application built with Flutter. It provides a multi-tenant solution with role-based access control, allowing different organizations to manage their invoices, clients, and employees securely.

The app is available on the [Google Play Store](https://play.google.com/store/apps/details?id=your.package.name).

## Features

*   **Multi-Tenant Architecture**: Each organization's data is isolated and secure.
*   **Role-Based Access Control**: Differentiates between business owners (admins) and employees with specific permissions.
*   **Secure Authentication**: Features secure user signup, login, and email verification.
*   **Business and Client Management**: Easily add, view, and manage businesses and clients.
*   **Invoice Generation**: Create and manage invoices with ease.
*   **Time Tracking**: Employees can track their time spent on different tasks.

## Backend

The backend for CareNest is a Node.js Express server. It is managed in a separate repository, which you can find here: [CareNest Backend](https://github.com/ErBishalBudhathoki/CareNest_backend.git)

## Installation and Setup

### Flutter App

1.  **Prerequisites**: Make sure you have Flutter installed. You can find instructions on how to install Flutter [here](https://flutter.dev/docs/get-started/install).
2.  **Clone the repository**: 
    ```bash
    git clone https://github.com/ErBishalBudhathoki/CareNest.git
    cd CareNest
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the app**:
    ```bash
    flutter run
    ```

### Backend Server

For instructions on how to set up the backend server, please refer to the `README.md` file in the [backend repository](https://github.com/BishalBudhathoki/carenest_backend.git).