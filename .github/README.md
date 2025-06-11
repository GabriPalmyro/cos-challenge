# GitHub Workflows

This project includes GitHub Actions workflows for automated building and testing.

## Workflows

### 1. `build-apk.yml` - Simple APK Build

- **Triggers**: Push/PR to main/master branches, manual dispatch
- **Purpose**: Basic APK build with tests
- **Outputs**: Single release APK

### 2. `build-and-test.yml` - Comprehensive Build & Test

- **Triggers**: Push/PR to main/master/develop branches, manual dispatch
- **Purpose**: Complete CI/CD with testing, code analysis, and flexible build options
- **Outputs**:
  - Split APKs (arm64-v8a, armeabi-v7a, x86_64)
  - App Bundle (AAB) - manual dispatch only
  - Test coverage reports

## Manual Builds

You can manually trigger builds from the GitHub Actions tab:

1. Go to your repository's **Actions** tab
2. Select **Build and Test** workflow
3. Click **Run workflow**
4. Choose build type:
   - `apk` - Builds split APKs for different architectures
   - `appbundle` - Builds AAB for Google Play Store

## Automatic Releases

When you create a git tag, the workflow will automatically:

1. Build the APK
2. Create a GitHub release
3. Upload the APK files to the release

To create a release:

```bash
git tag v1.0.0
git push origin v1.0.0
```

## Build Artifacts

All builds are stored as GitHub artifacts for 30 days and can be downloaded from the Actions tab.

## Prerequisites

- Your repository must have Actions enabled
- No additional secrets required for basic functionality
- For signed APKs, you'll need to add signing keys as repository secrets
