# Sensitive Files Guide

## Overview

This guide provides instructions for handling sensitive files in the Invoice App project. Proper management of sensitive files is crucial to prevent security breaches and protect user data.

## Identified Sensitive Files

The following sensitive files have been identified in the project:

### API Keys and Service Accounts

- `google-play-service-key.json` - Found in `/android/fastlane/`
- `firebase-admin-config.js` - Contains Firebase Admin SDK configuration
- Firebase configuration files:
  - `google-services.json` - Found in multiple locations for different flavors
  - `GoogleService-Info.plist` - Found in multiple locations for different flavors
- `firebase_options.dart` - Contains Firebase API keys (considered public by Firebase but should be restricted)

### Environment Variables

- `.env` - Contains sensitive information such as:
  - Email credentials
  - API keys (Google Maps, FCM server)
  - Firebase Admin SDK credentials
  - Debug tokens
  - Database passwords
  - Backend URLs

## Security Measures Implemented

1. **Updated .gitignore**: The `.gitignore` file has been updated to exclude all sensitive files from Git tracking.

2. **Security Guidelines**: A `SECURITY.md` file has been created with comprehensive security guidelines.

3. **Pre-commit Hook**: A pre-commit hook has been set up to automatically check for sensitive files before each commit.

4. **Sensitive Files Check Script**: A script (`scripts/check_sensitive_files.sh`) has been created to help developers identify sensitive files that should not be committed.

5. **Setup Guides**: Detailed guides have been created for sensitive configurations:
   - `GOOGLE_PLAY_API_KEY_GUIDE.md` - Instructions for setting up Google Play API key
   - `FIREBASE_ADMIN_SDK_GUIDE.md` - Instructions for setting up Firebase Admin SDK credentials

## How to Handle Sensitive Files

### For Local Development

1. **Environment Variables**:
   - Never commit `.env` files to the repository
   - Use `.env.example` files with placeholder values
   - Create your own `.env` file locally based on the example

2. **Firebase Configuration**:
   - Keep Firebase configuration files in their designated flavor directories
   - Apply proper security rules in Firebase console
   - Restrict API keys to your app's package name

3. **Google Play Service Key**:
   - Store the key securely outside the repository
   - For CI/CD, use environment secrets

4. **Firebase Admin SDK**:
   - Follow the instructions in `FIREBASE_ADMIN_SDK_GUIDE.md`
   - Store credentials in `.env` file (never commit this file)
   - For production, use environment variables provided by your hosting platform

### For CI/CD

1. **GitHub Secrets**:
   - Store sensitive information as GitHub Secrets
   - Reference these secrets in your workflow files

2. **Environment-specific Configuration**:
   - Use different configurations for development, staging, and production

## Best Practices

1. **Regular Audits**:
   - Run the sensitive files check script regularly
   - Review the `.gitignore` file to ensure it covers all sensitive files

2. **Credential Rotation**:
   - Regularly rotate credentials and API keys
   - Update all relevant documentation when rotating credentials

3. **Secure Communication**:
   - Always use HTTPS for API communication
   - Implement proper authentication and authorization

4. **Encryption**:
   - Encrypt sensitive data at rest and in transit
   - Use secure encryption algorithms and proper key management

## What to Do If Sensitive Information Is Accidentally Committed

1. **Immediate Action**:
   - Rotate all exposed credentials immediately
   - Remove the sensitive information from the repository history

2. **Notification**:
   - Notify the security team about the incident
   - Document the incident and the actions taken

## Running the Sensitive Files Check

To check for sensitive files that should not be committed:

```bash
./scripts/check_sensitive_files.sh
```

This script will scan the project for sensitive files and provide a report.

## Contact

If you have any questions or concerns about handling sensitive files, please contact the security team at [security@example.com](mailto:security@example.com).