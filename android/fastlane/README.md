fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android verify_version_code

```sh
[bundle exec] fastlane android verify_version_code
```

Fail unless this build's versionCode is strictly higher than every Google Play track

### android verify_store_metadata

```sh
[bundle exec] fastlane android verify_store_metadata
```

Validate Play listing metadata and screenshots without uploading anything

### android increment_version_code

```sh
[bundle exec] fastlane android increment_version_code
```

Increment the build number in pubspec.yaml (the source of truth for Flutter)

### android capture_screenshots

```sh
[bundle exec] fastlane android capture_screenshots
```

Capture screenshots for the store

### android deploy_development

```sh
[bundle exec] fastlane android deploy_development
```

Deploy development build to internal testing

### android deploy_production

```sh
[bundle exec] fastlane android deploy_production
```

Deploy production build to production track (DISABLED - use promote lane)

### android deploy_internal

```sh
[bundle exec] fastlane android deploy_internal
```

Deploy internal build to internal testing

### android upload_internal_aab

```sh
[bundle exec] fastlane android upload_internal_aab
```

Upload existing production AAB to internal testing (CI path)

### android upload_production_aab

```sh
[bundle exec] fastlane android upload_production_aab
```

Upload existing production AAB to production track (DISABLED)

### android promote_internal_to_production

```sh
[bundle exec] fastlane android promote_internal_to_production
```

Promote a TESTED internal release to production with listing metadata and screenshots

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
