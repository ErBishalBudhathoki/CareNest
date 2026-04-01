#!/bin/bash

# deploy_with_notes.sh - A script to automate the deployment process with release notes

set -e

show_help() {
  echo "Usage: ./deploy_with_notes.sh [options]"
  echo ""
  echo "Options:"
  echo "  --help                Show this help message"
  echo "  --minor               Perform a minor version update (0.1 increment)"
  echo "  --major               Perform a major version update (1.0 increment)"
  echo "  --development         Deploy to internal testing track"
  echo "  --production          Deploy to production track"
  echo "  --skip-build          Skip the Flutter build step"
  echo ""
  echo "Example:"
  echo "  ./deploy_with_notes.sh --minor --production  # Minor update and deploy to production"
}

MINOR_UPDATE=false
MAJOR_UPDATE=false
DEPLOY_DEVELOPMENT=false
DEPLOY_PRODUCTION=false
SKIP_BUILD=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
      show_help
      exit 0
      ;;
    --minor)
      MINOR_UPDATE=true
      ;;
    --major)
      MAJOR_UPDATE=true
      ;;
    --development)
      DEPLOY_DEVELOPMENT=true
      ;;
    --production)
      DEPLOY_PRODUCTION=true
      ;;
    --skip-build)
      SKIP_BUILD=true
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
  shift
done

# Check if we're in the android directory
if [[ ! -f "./update_version.sh" ]]; then
  echo "Error: This script must be run from the android directory"
  exit 1
fi

# Make sure update_version.sh is executable
chmod +x ./update_version.sh

# Show current version
echo "Current version:"
./update_version.sh --current-version

# Update version if requested
if [[ ("$DEPLOY_DEVELOPMENT" == "true" || "$DEPLOY_PRODUCTION" == "true") && "$MINOR_UPDATE" == "false" && "$MAJOR_UPDATE" == "false" ]]; then
  echo "No version update type specified for deployment. Defaulting to minor update (increment version code)."
  MINOR_UPDATE=true
fi

if [[ "$MINOR_UPDATE" == "true" ]]; then
  echo "\nPerforming minor version update..."
  ./update_version.sh --minor
  echo "Version after minor update:"
  ./update_version.sh --current-version
fi

if [[ "$MAJOR_UPDATE" == "true" ]]; then
  echo "\nPerforming major version update..."
  ./update_version.sh --major
  echo "Version after major update:"
  ./update_version.sh --current-version
fi

# Generate release notes if they don't exist
VERSION_NAME=$(grep "^version:" ../pubspec.yaml | sed 's/version: //' | cut -d'+' -f1)
RELEASE_NOTES_FILE="release_notes_${VERSION_NAME}.txt"

if [[ ! -f "$RELEASE_NOTES_FILE" ]]; then
  echo "\nGenerating release notes template..."
  ./update_version.sh --release-notes
  echo "Release notes template created: $RELEASE_NOTES_FILE"
fi

echo "================================================================"
echo "  PLEASE EDIT THE RELEASE NOTES FILE NOW: $RELEASE_NOTES_FILE"
echo "  The file has been created/found. Please add your changes."
echo "================================================================"

# Try to open the file based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    open -t "$RELEASE_NOTES_FILE" 2>/dev/null || true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$RELEASE_NOTES_FILE" 2>/dev/null || nano "$RELEASE_NOTES_FILE" || true
fi

read -p "Press Enter to continue with deployment after editing release notes (or Ctrl+C to cancel)..."

echo "Proceeding with deployment..."

# Ensure version is properly set in pubspec.yaml before building
if [[ "$DEPLOY_DEVELOPMENT" == "true" || "$DEPLOY_PRODUCTION" == "true" ]]; then
  echo "\nFinalizing version for deployment..."
  
  # Read current version from pubspec.yaml
  CURRENT_VERSION=$(grep "^version:" ../pubspec.yaml | sed 's/version: //')
  if [[ -z "$CURRENT_VERSION" ]]; then
    echo "Warning: No version found in pubspec.yaml"
    exit 1
  fi
  
  # Extract version name and code
  VERSION_NAME=$(echo "$CURRENT_VERSION" | cut -d'+' -f1)
  VERSION_CODE=$(echo "$CURRENT_VERSION" | cut -d'+' -f2)
  
  echo "Using version from pubspec.yaml:"
  echo "Version Name: $VERSION_NAME"
  echo "Version Code: $VERSION_CODE"
fi

# Build the app if not skipped
if [[ "$SKIP_BUILD" != "true" ]]; then
  echo "\nBuilding the app..."
  cd ..
  
  if [[ "$DEPLOY_DEVELOPMENT" == "true" ]]; then
    echo "Building development flavor..."
    flutter build appbundle --flavor development -t lib/main_development.dart --release
  fi
  
  if [[ "$DEPLOY_PRODUCTION" == "true" ]]; then
    echo "Building production flavor..."
    flutter build appbundle --flavor production -t lib/main_production.dart --release
  fi
  
  cd android
  
  echo "Final version information for deployment:"
  echo "Version from pubspec.yaml: $(grep "^version:" ../pubspec.yaml | sed 's/version: //')"
else
  echo "\nSkipping build step..."
fi

# Deploy with fastlane
if [[ "$DEPLOY_DEVELOPMENT" == "true" ]]; then
  echo "\nDeploying to internal testing track..."
  fastlane deploy_development
fi

if [[ "$DEPLOY_PRODUCTION" == "true" ]]; then
  echo "\nDeploying to production track..."
  fastlane android upload_production_aab
fi

echo "\nDeployment process completed!"
