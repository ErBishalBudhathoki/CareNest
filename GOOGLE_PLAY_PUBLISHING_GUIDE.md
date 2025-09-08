# Google Play Store Publishing Guide

This guide outlines the steps to publish your Flutter app to the Google Play Store using the existing Fastlane and CI/CD configuration.

## Prerequisites

1. **Google Play Console Account**: You need a developer account on the [Google Play Console](https://play.google.com/console/)
2. **App Signing Key**: Already configured in `android/key.properties`
3. **Google Play API Key**: Required for automated publishing via Fastlane

## Setup Steps

### 1. Create Google Play API Key

1. Log in to [Google Play Console](https://play.google.com/console/)
2. Navigate to **Setup** > **API access**
3. Link or create a Google Cloud project
4. Create a new service account:
   - Go to the Google Cloud Console
   - Create a service account
   - Grant it the "Service Account User" role
5. Back in Play Console, grant the following permissions to your service account:
   - App access: Select your app
   - Permission: Release manager
6. Create and download a JSON key for this service account
7. Save this JSON key as `google-play-service-key.json` in the `android/fastlane` directory

### 2. Create App in Google Play Console

1. In Google Play Console, click **Create app**
2. Fill in the app details:
   - App name: "Invoice" (for production) or "Invoice Dev" (for development)
   - Default language
   - App or game: App
   - Free or paid: Choose appropriate option
   - Confirm app details

3. Complete the required store listing information:
   - Description
   - Screenshots
   - Feature graphic
   - App icon
   - Content rating questionnaire
   - Target audience and content
   - Privacy policy URL

### 3. Manual Publishing (First Time)

For the first release, you'll need to manually upload an APK or AAB:

1. Build a release bundle:
   ```bash
   flutter build appbundle --flavor production
   ```

2. In Google Play Console, navigate to your app > **Production** > **Create new release**
3. Upload the AAB file from `build/app/outputs/bundle/productionRelease/app-production-release.aab`
4. Complete release details and submit for review

### 4. Automated Publishing via Fastlane

Once your app is approved and published, you can use the automated CI/CD pipeline for future updates:

#### Local Deployment

To deploy from your local machine:

1. Ensure the `google-play-service-key.json` is in the `android/fastlane` directory
2. Run the appropriate Fastlane command:

   For production:
   ```bash
   cd android
   fastlane deploy_production
   ```

   For development (internal testing):
   ```bash
   cd android
   fastlane deploy_development
   ```

#### GitHub Actions Deployment

To deploy using the GitHub Actions workflow:

1. Add the Google Play API key as a GitHub secret:
   - Go to your GitHub repository > Settings > Secrets > Actions
   - Create a new repository secret named `GOOGLE_PLAY_API_KEY`
   - Paste the entire contents of your `google-play-service-key.json` file

2. Trigger the workflow:
   - Automatically: Push to the main branch
   - Manually: Go to the Actions tab, select the "Flutter CI/CD" workflow, click "Run workflow", select the deployment target (development or production), and click "Run workflow"

## Version Management

The app version is managed in two parts:

1. **Version Code**: Automatically incremented by Fastlane before each deployment
2. **Version Name**: Managed in `android/local.properties` as `flutter.versionName`

To update the version name manually:

1. Edit `android/local.properties`
2. Update the `flutter.versionName` property

## Troubleshooting

### Common Issues

1. **Signing Issues**:
   - Ensure the keystore file exists at the path specified in `key.properties`
   - Verify the keystore passwords and alias are correct

2. **Google Play API Key Issues**:
   - Ensure the service account has the correct permissions in Google Play Console
   - Verify the JSON key file is correctly formatted and placed in the right location

3. **Build Failures**:
   - Check the build logs for specific error messages
   - Ensure all dependencies are up to date with `flutter pub get`

### Support Resources

- [Fastlane Documentation](https://docs.fastlane.tools/)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer/)
- [Flutter Deployment Documentation](https://docs.flutter.dev/deployment/android)

## Maintenance

### Updating App Metadata

To update app metadata (descriptions, screenshots, etc.):

1. Log in to Google Play Console
2. Navigate to your app > **Store presence** > **Store listing**
3. Make the necessary changes and save

### Managing Release Tracks

Your app is configured with two tracks:

- **Internal Testing** (development flavor): For internal testers only
- **Production** (production flavor): For public release

You can create additional tracks (alpha, beta) in the Google Play Console if needed.