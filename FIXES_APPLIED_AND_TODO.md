# Locai App - Critical Fixes Checklist

## ✅ COMPLETED FIXES

- [x] **Fixed TextEditingController Memory Leak** (chat_page.dart)
  - Added `dispose()` method to properly clean up the TextEditingController
  - Status: FIXED

- [x] **Fixed ReceivePort Resource Leak** (model_gallery_page.dart)
  - Added `_port.close()` in the dispose method
  - Status: FIXED

- [x] **Fixed _localPath TypeError** (model_service.dart)
  - Changed `await _localPath` to `await localPath`
  - Status: FIXED

- [x] **Disabled Debug Mode** (main.dart)
  - Changed `debug: true` → `debug: false`
  - Changed `ignoreSsl: true` → `ignoreSsl: false`
  - Status: FIXED

- [x] **Added Error Handling** (model_service.dart)
  - Added try-catch blocks to `isModelDownloaded()` and `deleteModel()`
  - Modified `runInference()` to return ReceivePort for proper cleanup
  - Status: FIXED

---

## ⏳ REMAINING CRITICAL ACTIONS

### 1. Update Package Identifier (Android)
**File:** `android/app/build.gradle.kts`

**Current:**
```kotlin
namespace = "com.example.locai"
applicationId = "com.example.locai"
```

**Action:**
Replace `com.example.locai` with your organization's unique package name:
```kotlin
namespace = "com.yourcompany.locai"
applicationId = "com.yourcompany.locai"
```

**Why:** App stores won't accept apps with the `com.example.*` package name. Each app must have a unique package identifier.

**Example Valid Names:**
- `com.google.locai`
- `com.mycompany.locai`
- `io.github.myusername.locai`
- `com.myname.locai`

---

### 2. Update iOS Bundle Identifier
**File:** `ios/Runner/Info.plist` & `ios/Runner.xcodeproj`

**Action:**
1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select Runner project
3. Go to Build Settings
4. Change Bundle Identifier from default to your unique identifier
5. Update in Info.plist:
   ```xml
   <key>CFBundleIdentifier</key>
   <string>com.yourcompany.locai</string>
   ```

---

### 3. Configure Release Build Signing (Android)
**File:** `android/app/build.gradle.kts`

**Current:**
```kotlin
buildTypes {
  release {
    signingConfig = signingConfigs.getByName("debug")  // ❌ Won't work for stores
  }
}
```

**Action Steps:**

#### Step A: Generate a Release Key
```bash
cd android/app
keytool -genkey -v -keystore release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias release
```

**When prompted, enter:**
- Keystore password: (create a strong password)
- Key alias password: (same password)
- Full name, organization, city, state, country

#### Step B: Create `local.properties` in the android folder
```properties
RELEASE_STORE_FILE=app/release.keystore
RELEASE_STORE_PASSWORD=your_keystore_password
RELEASE_KEY_ALIAS=release
RELEASE_KEY_PASSWORD=your_keystore_password
```

#### Step C: Update `build.gradle.kts`
```kotlin
signingConfigs {
  release {
    storeFile = file(System.getenv("RELEASE_STORE_FILE") ?: "keystore.jks")
    storePassword = System.getenv("RELEASE_STORE_PASSWORD")
    keyAlias = System.getenv("RELEASE_KEY_ALIAS")
    keyPassword = System.getenv("RELEASE_KEY_PASSWORD")
  }
}

buildTypes {
  release {
    signingConfig = signingConfigs.getByName("release")  // ✅ Use release key
  }
}
```

**Security Note:** NEVER commit `local.properties` or store passwords in the repository. Use environment variables for CI/CD pipelines.

---

### 4. Update Version Numbers
**File:** `pubspec.yaml`

**Current:**
```yaml
version: 0.1.0+1
```

**Action:**
Before any release, update to proper semantic versioning:
```yaml
version: 1.0.0+1  # Major.Minor.Patch+BuildNumber
```

**Guidelines:**
- First number (1): Major version
- Second number (0): Minor version (new features)
- Third number (0): Patch version (bug fixes)
- After +: Build number (increment for each build)

---

### 5. Update Permissions Documentation

**Android Manifests Needed:**
In `android/app/src/main/AndroidManifest.xml`, ensure these permissions are declared:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

**iOS Info.plist Entries Needed:**
```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app requires access to your local network to download models</string>
<key>NSBonjourServiceTypes</key>
<array>
  <string>_http._tcp</string>
</array>
```

---

## 🧪 Testing Checklist Before Release

### Functional Testing
- [ ] Open app on fresh device - check no crashes
- [ ] Model download works without errors
- [ ] Model switching clears chat properly
- [ ] Message sending/receiving works smoothly
- [ ] Screen navigation doesn't show memory issues
- [ ] No console errors during normal usage

### Resource Leak Testing
```bash
# Run with memory monitoring
flutter run --verbose

# Check for leaks in console output. 
# WARNING: Look for messages about unclosed resources
```

### Performance Testing
- [ ] App loads in < 3 seconds
- [ ] No jank during scrolling
- [ ] Model inference doesn't freeze UI
- [ ] Download doesn't block navigation

### Platform-Specific Testing
**Android:**
- [ ] Test on Android 7.0+ (API 21+)
- [ ] Test on both small and large screens
- [ ] Test release build: `flutter build apk --release`

**iOS:**
- [ ] Test on iOS 12.0+
- [ ] Test on both iPhone and iPad
- [ ] Test release build: `flutter build ipa --release`

---

## 🚀 Pre-Release Deployment Steps

### Before Google Play Store:
1. Create Google Play Developer account
2. Generate signed APK:
   ```bash
   flutter build apk --release --split-per-abi
   ```
3. Test APK on real device
4. Upload to Play Console

### Before Apple App Store:
1. Create Apple Developer account
2. Create App ID in App Store Connect
3. Generate signing certificate
4. Build IPA:
   ```bash
   flutter build ipa --release
   ```
5. Upload via Xcode or Transporter

---

## 📋 Final Verification

Before submitting to stores, verify:

```bash
# Check for any analysis issues
flutter analyze

# Run tests (if any exist)
flutter test

# Verify iOS build
flutter build ios --release

# Verify Android build
flutter build appbundle --release

# Check all fixes applied
grep -n "_textController.dispose()" lib/screens/chat_page.dart
grep -n "_port.close()" lib/screens/model_gallery_page.dart
grep -n "await localPath" lib/services/model_service.dart
grep -n "debug: false" lib/main.dart
grep -n "ignoreSsl: false" lib/main.dart
```

---

## 🔒 Security Checklist

- [ ] No hardcoded credentials in code
- [ ] No debug mode enabled in release builds
- [ ] SSL verification enabled
- [ ] All error messages don't expose internal details
- [ ] File permissions restricted appropriately
- [ ] No sensitive data logged
- [ ] Package identifier is unique

---

## 📞 Support & Documentation

Once completed, document:
1. **Installation:** How to build and run the app
2. **Configuration:** What needs to be configured before deployment
3. **Troubleshooting:** Common issues and solutions
4. **Release Process:** Steps for future releases

---

**Status:** 5 of 10 critical items fixed. Remaining items are configuration-based and require manual build setup.

**Estimated Time to Complete:** 2-3 hours for experienced developer
