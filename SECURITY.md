# Security Guidelines for Invoice App

## Sensitive Files Protection

This project contains several sensitive files that should **never** be committed to the repository. The `.gitignore` file has been configured to exclude these files, but developers should be aware of them:

### API Keys and Service Accounts

- `google-play-service-key.json` - Google Play API key for app deployment
- `firebase-service-account.json` - Firebase service account credentials
- `firebase-admin-config.js` - Firebase admin configuration
- `google-services.json` - Firebase configuration for Android
- `GoogleService-Info.plist` - Firebase configuration for iOS

### Environment Variables

- `.env` - Contains sensitive API keys, passwords, and configuration
- Any file matching `*.env.*` pattern

### Keystores and Certificates

- `*.jks` - Java KeyStore files
- `*.keystore` - Android keystore files
- `*.p8` - Apple Push Notification service keys
- `*.p12` - PKCS #12 certificates
- `*.key` - Private key files
- `*.mobileprovision` - iOS provisioning profiles

## Handling Sensitive Information

### For Local Development

1. Create a `.env.example` file with placeholder values (no real credentials)
2. Developers should copy `.env.example` to `.env` and add their own credentials
3. Use environment-specific configuration for different environments (dev, staging, prod)

### For CI/CD

1. Store sensitive information in GitHub Secrets or other secure CI/CD variables
2. Never print sensitive information in CI/CD logs
3. Rotate credentials regularly

### Firebase Configuration

The `firebase_options.dart` file contains API keys that are considered public by Firebase. These keys are restricted by Firebase Security Rules and API restrictions, so they are safe to include in the repository. However, it's still a good practice to restrict these keys to your app's package name and apply proper security rules in Firebase.

## Security Best Practices

1. Use environment variables for sensitive configuration
2. Implement proper authentication and authorization
3. Encrypt sensitive data at rest and in transit
4. Regularly update dependencies to patch security vulnerabilities
5. Implement proper input validation to prevent injection attacks
6. Use secure communication protocols (HTTPS)
7. Implement proper error handling that doesn't expose sensitive information

## Reporting Security Issues

If you discover a security vulnerability, please send an email to [security@example.com](mailto:security@example.com) rather than opening a public issue.