# Firebase Admin SDK Setup Guide

This guide explains how to set up Firebase Admin SDK credentials for the Invoice App backend.

## Prerequisites

- Firebase project created in [Firebase Console](https://console.firebase.google.com/)
- Admin access to your Firebase project
- Node.js and npm installed

## Steps to Generate Firebase Admin SDK Credentials

### 1. Access Firebase Project Settings

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on the gear icon (⚙️) next to "Project Overview" to access Project settings

### 2. Create a Service Account

1. Navigate to the "Service accounts" tab
2. Under "Firebase Admin SDK", click "Generate new private key"
3. Click "Generate key" in the popup dialog
4. A JSON file will be downloaded to your computer
5. **IMPORTANT**: This file contains sensitive credentials. Keep it secure and never commit it to version control.

### 3. Set Up Environment Variables

1. Copy the `.env.example` file in the `backend` directory to create a new `.env` file:
   ```bash
   cp backend/.env.example backend/.env
   ```

2. Open the downloaded service account JSON file and copy the values to your `.env` file:
   ```
   FIREBASE_PROJECT_ID=your-project-id
   FIREBASE_PRIVATE_KEY_ID=your-private-key-id
   FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYour Private Key Here\n-----END PRIVATE KEY-----\n"
   FIREBASE_CLIENT_EMAIL=your-client-email@your-project.iam.gserviceaccount.com
   FIREBASE_CLIENT_ID=your-client-id
   FIREBASE_CLIENT_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/your-client-email%40your-project.iam.gserviceaccount.com
   ```

   **Note**: For `FIREBASE_PRIVATE_KEY`, make sure to:
   - Include the entire key including the `-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----` parts
   - Replace newlines (`\n`) in the private key with actual newlines or keep them as `\n` in the .env file

### 4. Verify Configuration

1. Start the backend server:
   ```bash
   cd backend
   npm install
   npm start
   ```

2. Check the console logs for successful Firebase Admin SDK initialization:
   ```
   Firebase Admin SDK initialized successfully
   ```

## Security Best Practices

1. **Never commit the service account JSON file** to version control
2. **Never commit your `.env` file** to version control
3. For production deployments, use environment variables provided by your hosting platform
4. Regularly rotate your service account keys
5. Apply the principle of least privilege - only grant necessary permissions to your service account

## Troubleshooting

### Error: "Firebase App initialization error"

- Verify that all environment variables are correctly set
- Check that the private key is properly formatted with newlines
- Ensure the service account has the necessary permissions in Firebase

### Error: "Error parsing private key"

- Make sure the private key is properly escaped in the .env file
- Try regenerating the service account key

## CI/CD Configuration

For CI/CD pipelines, securely add the Firebase Admin SDK credentials as environment variables or secrets in your CI/CD platform.

## References

- [Firebase Admin SDK Documentation](https://firebase.google.com/docs/admin/setup)
- [Environment Variables Best Practices](https://12factor.net/config)