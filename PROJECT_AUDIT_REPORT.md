# Flutter Project Audit Report - Locai App

**Date:** April 28, 2026  
**Project:** Locai (Flutter AI Chat Application)  
**Severity:** Mixed (Critical, High, Medium)

---

## 🔴 CRITICAL ISSUES (Must Fix)

### 1. **Memory Leak: TextEditingController Not Disposed**
**File:** [lib/screens/chat_page.dart](lib/screens/chat_page.dart)  
**Severity:** CRITICAL

The `_textController` is created in `_ChatPageState` but never disposed in the `dispose()` method. This causes memory leaks when the page is disposed.

**Current Code:**
```dart
class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  
  // No dispose() method!
}
```

**Fix Required:**
```dart
@override
void dispose() {
  _textController.dispose();
  super.dispose();
}
```

---

### 2. **ReceivePort Not Closed in ModelGalleryPage**
**File:** [lib/screens/model_gallery_page.dart](lib/screens/model_gallery_page.dart)  
**Severity:** CRITICAL

The `_port` ReceivePort is registered and listens for messages but is never closed. This causes resource leaks and background listeners remaining active.

**Current Code:**
```dart
@override
void dispose() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  // _port is never closed!
  super.dispose();
}
```

**Fix Required:**
```dart
@override
void dispose() {
  _port.close();  // Add this line
  IsolateNameServer.removePortNameMapping('downloader_send_port');
  super.dispose();
}
```

---

### 3. **Static Method Reference Error in ModelService**
**File:** [lib/services/model_service.dart](lib/services/model_service.dart)  
**Severity:** CRITICAL

The `getModelFile()` method references `_localPath` (private getter) instead of `localPath` (public getter). This will cause a runtime error.

**Current Code:**
```dart
static Future<File> getModelFile(String fileName) async {
  final path = await _localPath;  // ❌ WRONG - _localPath doesn't exist
  return File('$path/$fileName');
}
```

**Fix Required:**
```dart
static Future<File> getModelFile(String fileName) async {
  final path = await localPath;  // ✅ CORRECT
  return File('$path/$fileName');
}
```

---

## 🟠 HIGH PRIORITY ISSUES

### 4. **Release Build Uses Debug Signing Keys**
**File:** [android/app/build.gradle.kts](android/app/build.gradle.kts)  
**Severity:** HIGH

The release build configuration still signs with debug keys. This won't work for App Store/Play Store deployment.

**Current Code:**
```kotlin
buildTypes {
  release {
    // TODO: Add your own signing config for the release build.
    signingConfig = signingConfigs.getByName("debug")  // ❌ Using debug keys!
  }
}
```

**Action Required:** 
- Create a release signing key
- Configure proper signing config in build.gradle.kts
- Update to production certificate for app stores

---

### 5. **Debug Mode Enabled in FlutterDownloader**
**File:** [lib/main.dart](lib/main.dart)  
**Severity:** HIGH

Debug mode is enabled which will log sensitive information to console.

**Current Code:**
```dart
await FlutterDownloader.initialize(
  debug: true, // ❌ Should be false for production
  ignoreSsl: true,
);
```

**Fix Required:**
```dart
await FlutterDownloader.initialize(
  debug: false, // Set to false in production
  ignoreSsl: false, // Also disable for production security
);
```

---

### 6. **Invalid Package Identifier**
**File:** [android/app/build.gradle.kts](android/app/build.gradle.kts) & [ios/Runner/Info.plist](ios/Runner/Info.plist)  
**Severity:** HIGH

Package ID is still the example placeholder `com.example.locai`. This won't work for app store deployment.

**Current Values:**
- Android: `com.example.locai`
- iOS: Not set properly

**Fix Required:**
- Update Android applicationId to unique package name (e.g., `com.yourdomain.locai`)
- Update iOS bundle identifier in Xcode
- Update iOS Info.plist CFBundleIdentifier

---

## 🟡 MEDIUM ISSUES

### 7. **Missing Error Handling in Model Operations**
**File:** [lib/services/model_service.dart](lib/services/model_service.dart)  
**Severity:** MEDIUM

Methods lack try-catch blocks. Failures in file operations will crash the app.

**Example Issue:**
```dart
static Future<void> deleteModel(String fileName) async {
  final file = await getModelFile(fileName);
  if (await file.exists()) {
    await file.delete();  // ❌ No error handling
  }
}
```

**Recommendation:** Wrap file operations in try-catch blocks.

---

### 8. **Missing Error Handling in Screen Navigation**
**File:** [lib/main.dart](lib/main.dart)  
**Severity:** MEDIUM

Push/Pop navigation operations should handle edge cases.

**Example:**
```dart
onTap: () {
  Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileSupportPage()));
  // No error handling if navigation fails
}
```

---

### 9. **Potential Issue with Isolate Cleanup in ModelService**
**File:** [lib/services/model_service.dart](lib/services/model_service.dart)  
**Severity:** MEDIUM

The `runInference()` method spawns an isolate and opens a ReceivePort but:
- Never closes the ReceivePort
- No mechanism to kill the isolate if operation is cancelled

**Current Code:**
```dart
static Future<void> runInference(Function(dynamic) onToken) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_inferenceIsolate, receivePort.sendPort);
  receivePort.listen((message) {
    onToken(message);
    // ❌ No cleanup
  });
}
```

---

### 10. **Missing Null Safety Checks**
**File:** Multiple files  
**Severity:** MEDIUM

Several nullable values are used without null checks:

Examples:
- `_selectedModel` can be null in dropdown operations
- `_availableModels` could be empty but accessed directly

---

## 🟢 MINOR ISSUES

### 11. **SSL Certificate Verification Disabled**
**File:** [lib/main.dart](lib/main.dart)

```dart
ignoreSsl: true,  // ⚠️ Security risk, only for development
```

---

### 12. **Comments with TODOs Still in Code**
- Android: "TODO: Specify your own unique Application ID"
- Android: "TODO: Add your own signing config for the release build"

These should be resolved before production.

---

### 13. **Mounting Check in Delayed Operation**
**File:** [lib/screens/chat_page.dart](lib/screens/chat_page.dart)

Good practice of checking `if (mounted)` before setState in delayed operations, but this pattern should be applied consistently throughout.

---

## 📋 SUMMARY TABLE

| Issue | File | Type | Impact | Status |
|-------|------|------|--------|--------|
| TextEditingController not disposed | chat_page.dart | Memory Leak | High | ❌ Not Fixed |
| ReceivePort not closed | model_gallery_page.dart | Resource Leak | Critical | ❌ Not Fixed |
| _localPath typo | model_service.dart | Runtime Error | Critical | ❌ Not Fixed |
| Debug signing keys | build.gradle.kts | Deployment | High | ❌ Not Fixed |
| Debug mode enabled | main.dart | Security/Logging | High | ❌ Not Fixed |
| Invalid package ID | Multiple | Deployment | High | ❌ Not Fixed |
| Missing error handling | model_service.dart | Robustness | Medium | ⚠️ Partial |
| Isolate not cleaned | model_service.dart | Resource Leak | Medium | ❌ Not Fixed |
| SSL verification off | main.dart | Security | Low | ⚠️ For Dev |

---

## ✅ ACTION ITEMS (Priority Order)

### Phase 1: Critical Fixes (Must do before any release)
- [ ] Fix TextEditingController memory leak in ChatPage
- [ ] Close ReceivePort in ModelGalleryPage dispose
- [ ] Fix _localPath typo in ModelService
- [ ] Update app package identifier
- [ ] Fix release build signing configuration

### Phase 2: High Priority
- [ ] Disable debug mode in FlutterDownloader
- [ ] Enable SSL verification
- [ ] Add comprehensive error handling
- [ ] Add null safety checks

### Phase 3: Cleanup
- [ ] Remove all TODO comments
- [ ] Add proper documentation
- [ ] Test on actual devices
- [ ] Performance profiling

---

## 🔒 Security Checklist

- [ ] Package identifier is unique (not com.example.*)
- [ ] Debug flags are false in release builds
- [ ] SSL/TLS verification enabled
- [ ] Permissions properly scoped and documented
- [ ] Sensitive data not logged
- [ ] Storage permissions handled correctly
- [ ] Model files stored securely

---

## 📱 Platform Compliance

### Android
- [ ] Proper AndroidManifest.xml permissions
- [ ] Correct minSdk/targetSdk versions (17/35)
- [ ] Release signing key configured
- [ ] App ID updated

### iOS
- [ ] Info.plist properly configured
- [ ] Bundle identifier set correctly
- [ ] Proper permissions in Info.plist
- [ ] CocoaPods dependencies resolved

---

## 💡 Recommendations

1. **Add State Management**: Consider using Provider or Riverpod for better state management and avoiding memory leaks
2. **Implement Logging**: Add proper logging system instead of debug flags
3. **Add Unit Tests**: Test ModelService and critical operations
4. **Component Lifecycle**: Review all StatefulWidget dispose methods
5. **Performance Monitoring**: Add crash reporting and monitoring
6. **Code Review**: Set up CI/CD pipeline with linting rules

---

**Next Step:** Start with Phase 1 critical fixes before proceeding to development or testing.
