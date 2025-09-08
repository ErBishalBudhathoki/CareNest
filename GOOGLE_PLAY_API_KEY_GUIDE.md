# Creating a Google Play API Key for Fastlane

This guide provides step-by-step instructions for creating and configuring a Google Play API key for automated deployments with Fastlane in the Invoice app project.

## Prerequisites

- Google Play Console account with the Invoice app published
- Google Cloud Console project linked to your Play Console
- GitHub repository for the Invoice app

## Step 1: Link Your Google Play Console to Google Cloud Project

1. Log in to [Google Play Console](https://play.google.com/console/)
2. Go to **Setup** > **API access**
3. If you haven't already linked your Play Console to your Google Cloud project, click **Choose a project to link** and select your existing Google Cloud project

## Step 2: Create a Service Account

1. In the API access page, under **Service accounts**, click **Create service account**
2. You'll be redirected to Google Cloud Console
3. In the service account creation page:
   - **Service account name**: Enter a name (e.g., "fastlane-deploy")
   - **Service account description**: Optional description (e.g., "Service account for Fastlane deployments")
   - Click **Create and continue**
4. In the **Grant this service account access to project** section:
   - Select **Service Account User** role
   - Click **Continue**
5. In the **Grant users access to this service account** section:
   - You can skip this step
   - Click **Done**

## Step 3: Grant Permissions in Google Play Console

1. Return to Google Play Console > **Setup** > **API access**
2. Under **Service accounts**, you should see your newly created service account
3. Click **Grant access** next to the service account
4. In the permissions dialog:
   - Select your app from the list
   - Under **App permissions**, select the following permissions:
     - **View app information and download bulk reports**
     - **Release to production** (for production deployment)
     - **Release to internal testing** (for development deployment)
     - **Manage testing tracks and releases** (for managing test tracks)
   - Click **Invite user**

## Step 4: Create and Download JSON Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Navigate to **IAM & Admin** > **Service Accounts**
3. Find your service account in the list and click on it
4. Go to the **Keys** tab
5. Click **Add Key** > **Create new key**
6. Select **JSON** as the key type
7. Click **Create**
8. The JSON key file will be automatically downloaded to your computer

## Step 5: Add the Key to Your Project

1. Rename the downloaded JSON file to `google-play-service-key.json`
2. Move the file to the `android/fastlane` directory in your Flutter project
3. Ensure the file is properly referenced in your Fastfile:

```ruby
# In android/fastlane/Fastfile
upload_to_play_store(
  track: "internal", # or "production" for production lane
  json_key: "google-play-service-key.json",
  package_name: "com.bishal.invoice.dev" # or "com.bishal.invoice" for production
)
```

## Step 6: Add the Key to GitHub Secrets (for CI/CD)

1. Go to your GitHub repository
2. Navigate to **Settings** > **Secrets** > **Actions**
3. Click **New repository secret**
4. Set the name to `GOOGLE_PLAY_API_KEY`
5. For the value, copy and paste the entire contents of the JSON key file
6. Click **Add secret**

This secret is used in the GitHub Actions workflow file (`.github/workflows/flutter_ci.yml`):

```yaml
- name: Deploy to Google Play
  if: github.event_name == 'push' || github.event_name == 'workflow_dispatch'
  env:
    GOOGLE_PLAY_API_KEY: ${{ secrets.GOOGLE_PLAY_API_KEY }}
  run: |
    echo "$GOOGLE_PLAY_API_KEY" > android/fastlane/google-play-service-key.json
    cd android
    fastlane deploy_${{ github.event.inputs.deploy_target || 'production' }}
```

## Important Security Notes

- **Never commit the JSON key file to your repository**
- Make sure `.gitignore` includes the key file pattern (`**/google-play-service-key.json`)
- The key grants access to publish to your app, so keep it secure
- If you suspect the key has been compromised, delete it and create a new one

## Verifying the Setup

To verify that your API key is working correctly:

1. Run a local Fastlane deployment:
   ```bash
   cd android
   fastlane deploy_development
   ```

2. Check the logs for any authentication errors

If everything is set up correctly, Fastlane should be able to authenticate with Google Play and upload your app bundle.

## Troubleshooting

### Common Issues

1. **Authentication Error**: Ensure the service account has the correct permissions in Google Play Console
2. **File Not Found**: Verify the path to the JSON key file in your Fastfile
3. **Invalid JSON**: Make sure the JSON key file is properly formatted
4. **Permission Denied**: Check that the service account has been granted the necessary permissions for the specific app

### Revoking Access

If you need to revoke access for a service account:

1. Go to Google Play Console > **Setup** > **API access**
2. Find the service account and click **Revoke access**
3. Go to Google Cloud Console > **IAM & Admin** > **Service Accounts**
4. Select the service account and delete any keys

## Related Documentation

- [Fastlane Supply Documentation](https://docs.fastlane.tools/actions/supply/)
- [Google Play Developer API](https://developers.google.com/android-publisher)
- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)