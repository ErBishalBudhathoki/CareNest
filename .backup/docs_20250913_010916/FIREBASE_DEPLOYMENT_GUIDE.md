# Firebase Admin SDK Deployment Guide

## Overview

This guide explains how to securely handle Firebase Admin SDK credentials during deployment without committing sensitive information to the repository.

## Problem

The application requires Firebase Admin SDK credentials to function, but these credentials should not be committed to the repository for security reasons. The `firebase-admin-config.js` file contains sensitive credentials and is listed in `.gitignore`, but the application expects this file to exist during runtime.

## Solution

We've implemented a solution that:

1. Uses a template file (`firebase-admin-config.js.template`) that reads credentials from environment variables
2. Includes a script that generates the actual configuration file during deployment
3. Updates the npm scripts to run this generation script automatically

## How It Works

### 1. Template File

The `firebase-admin-config.js.template` file is a version-controlled template that reads Firebase credentials from environment variables. This file doesn't contain any sensitive information itself.

### 2. Generation Script

The `scripts/generate-firebase-config.js` script copies the template to create the actual `firebase-admin-config.js` file during deployment.

### 3. Automatic Execution

The script is automatically executed:
- During application startup (`npm start`)
- After dependencies are installed (`npm postinstall`)

## Deployment Setup

### Required Environment Variables

Ensure these environment variables are set in your deployment environment (e.g., Render, Heroku, etc.):

```
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY_ID=your-private-key-id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYour Private Key Here\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=your-client-email@your-project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your-client-id
FIREBASE_CLIENT_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/your-client-email%40your-project.iam.gserviceaccount.com
```

### Render Deployment

For Render deployments:

1. Add all the required environment variables in the Render dashboard
2. Make sure to properly format the `FIREBASE_PRIVATE_KEY` with escaped newlines
3. The build command will automatically run `npm install`, which triggers the `postinstall` script

## Troubleshooting

### Error: "MODULE_NOT_FOUND"

If you encounter a `MODULE_NOT_FOUND` error for `./firebase-admin-config`:

1. Verify that all required environment variables are set
2. Check the application logs for any errors during the generation script execution
3. Ensure the `scripts/generate-firebase-config.js` file has execute permissions

### Error: "Error initializing Firebase Admin SDK"

If Firebase initialization fails:

1. Check that the private key is properly formatted with newlines
2. Verify that all environment variables contain the correct values
3. Ensure the service account has the necessary permissions in Firebase

## Local Development

For local development:

1. Create a `.env` file based on `.env.example`
2. Add your Firebase credentials to the `.env` file
3. Run `node scripts/generate-firebase-config.js` to generate the configuration file
4. Start the application with `npm run dev`

## Security Best Practices

1. Never commit the `firebase-admin-config.js` file to version control
2. Never commit your `.env` file to version control
3. Regularly rotate your service account keys
4. Apply the principle of least privilege - only grant necessary permissions to your service account