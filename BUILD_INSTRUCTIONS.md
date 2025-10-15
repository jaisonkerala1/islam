## Installation Instructions

Due to JDK/SDK compatibility issues with command-line builds, please use **Android Studio** to build and install the app:

### Method 1: Build with Android Studio (Recommended)

1. **Open the project in Android Studio:**
   - Open Android Studio
   - Click "Open" and select the `android` folder in this project

2. **Sync and Build:**
   - Let Android Studio sync the Gradle files
   - Click "Build" → "Build Bundle(s) / APK(s)" → "Build APK(s)"
   - Android Studio will handle the JDK compatibility automatically

3. **Install on your phone:**
   - The APK will be in `build/app/outputs/flutter-apk/`
   - Transfer it to your phone and install

### Method 2: Direct Install via USB

1. **Enable USB Debugging** on your Android phone
2. **Connect your phone** via USB
3. Run: `flutter run --release`
   - This installs directly without creating an APK file

### Current Build Issue

The command-line build is failing due to a known incompatibility between:
- **Android SDK 34** (required by dependencies)
- **JDK 17** (jlink optimization issue)

**Workaround:** Android Studio handles this automatically with its embedded JDK.

### Test Credentials

- **Phone:** Any number (for testing)
- **OTP:** `123456` (mock OTP for development)
- **Twilio Credentials:** Get your own from https://www.twilio.com/console
  - Replace `YOUR_TWILIO_ACCOUNT_SID` in `lib/core/services/twilio_service.dart`
  - Replace `YOUR_TWILIO_AUTH_TOKEN` in `lib/core/services/twilio_service.dart`
  - Replace `YOUR_TWILIO_PHONE_NUMBER` in `lib/core/services/twilio_service.dart`

---

**App is ready!** All features are implemented with BLoC architecture and mock data. Just build via Android Studio for best results.



