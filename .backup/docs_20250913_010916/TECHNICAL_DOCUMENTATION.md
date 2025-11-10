# Technical Documentation - Invoice App

## Project Overview
A Flutter-based invoice management application with NDIS (National Disability Insurance Scheme) support, featuring scheduling, client management, and real-time notifications.

## Current Status
- ✅ Backend server running on Node.js
- ✅ Flutter app running on iPhone 16 Plus simulator
- ✅ Firebase integration active
- ⚠️ APNS token setup needed for iOS push notifications
- ✅ Local notifications working

## Tech Stack

### Frontend
- **Flutter**: ^3.22.0 (Currently running 3.32.2)
- **Dart**: 3.8.1
- **State Management**: Riverpod ^2.6.1

### Backend
- **Node.js**: Express server
- **Database**: Not explicitly defined in current scan
- **Environment**: Development and Production configs

### Mobile Platform Versions
- **Android SDK**: 36.0.0
- **Android Build Tools**: 36.0.0
- **iOS**: Supporting iPhone 16 Plus
- **Java**: OpenJDK 17

### Firebase Services
- **Firebase Core**: Initialized
- **Firebase Messaging**: FCM for push notifications
- **Firebase Auth**: User authentication
- **Firebase Storage**: File uploads
- **Cloud Firestore**: Database

### Key Dependencies
- **Riverpod**: State management
- **Firebase**: Backend services
- **Local Notifications**: flutter_local_notifications
- **File Picker**: Document/image selection
- **Image Cropper**: Image processing
- **PDF**: pdfx for PDF handling
- **Maps**: Google Maps integration
- **Speech to Text**: Voice input
- **SQLite**: Local database (sqflite_android)

## Project Structure

### Main Directories
```
lib/
├── app/
│   ├── core/           # Core services (timer, file upload)
│   ├── features/       # Feature modules
│   │   ├── invoice/    # Invoice management
│   │   └── notifications/ # Notification system
│   ├── routes/         # Navigation
│   ├── services/       # App services
│   └── shared/         # Shared utilities and widgets
├── backend/            # API methods and responses
├── env.dart           # Environment configuration
└── main.dart          # App entry point
```

### Key Features
1. **NDIS Integration**: Support for NDIS items and pricing
2. **Scheduling**: Time/date picker with break management
3. **Client Management**: Organization-based client assignment
4. **Invoice Generation**: PDF generation and email integration
5. **Real-time Notifications**: Firebase + Local notifications
6. **Timer Service**: Work time tracking
7. **File Management**: Photo attachments and document uploads
8. **Authentication**: Firebase Auth with role-based access

## Environment Configuration

### Debug vs Release
- **Debug URL**: Configured via .env file
- **Release URL**: Production endpoint
- **Current Mode**: Debug mode active

### API Endpoints
- Base URL configured in `api_method.dart`
- Supports both debug and release environments
- Comprehensive error handling implemented

## Current Issues & Fixes

### Known Issues
1. **APNS Token**: iOS push notifications need APNS token setup
2. **Analysis Server**: Flutter analyze command failing (exit code 64)
3. **Local Network Permissions**: iOS simulator permission warnings

### Recent Fixes
- **Logout Navigation**: Fixed bottom navigation persistence after logout
- **Custom Pricing**: Enhanced NDIS item pricing with per-schedule customization
- **Notification System**: Comprehensive notification handling implemented

## Development Setup

### Running the Application
1. **Backend**: `node server.js` (Port configured in .env)
2. **Flutter iOS**: `flutter run -d "iPhone 16 Plus"`
3. **Flutter General**: `flutter run`

### Active Terminals
- Terminal 10: Backend server (Node.js)
- Terminal 12: Flutter iOS app
- Terminal 13: Flutter general

### Build Configuration
- **Android**: Gradle 7.3.0/8.14.3
- **iOS**: Xcode project configured
- **Debug Mode**: Enabled with comprehensive logging

## Database Schema

### Key Entities
- **Users**: Authentication and profile management
- **Clients**: Client information and assignments
- **Organizations**: Multi-tenant support
- **NDIS Items**: Support items with pricing
- **Schedules**: Appointment and work scheduling
- **Invoices**: Billing and payment tracking
- **Notifications**: Real-time messaging

## Security
- **Firebase Auth**: Secure authentication
- **Role-based Access**: Admin, user, client roles
- **API Security**: Token-based authentication
- **Environment Variables**: Sensitive data in .env files

## Performance Considerations
- **State Management**: Riverpod for efficient state updates
- **Image Processing**: Optimized image cropping and compression
- **Local Storage**: SQLite for offline capabilities
- **Caching**: Notification and data caching implemented

## Monitoring & Debugging
- **Comprehensive Logging**: Debug prints throughout application
- **Error Handling**: Try-catch blocks with user feedback
- **Firebase Analytics**: Performance monitoring
- **Local Logs**: Flutter log files (flutter_01.log to flutter_10.log)

## Next Steps
1. Fix APNS token setup for iOS push notifications
2. Resolve Flutter analyze command issues
3. Complete any pending NDIS pricing enhancements
4. Optimize notification delivery performance
5. Implement additional error recovery mechanisms

---

**Last Updated**: 2025-07-30
**Flutter Version**: 3.32.2
**Dart Version**: 3.8.1
**Status**: Development Active