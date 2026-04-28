# App Permissions Configuration

**Date:** April 28, 2026
**App:** Locai (AI Chat Application)

---

## 📱 **Android Permissions** (`android/app/src/main/AndroidManifest.xml`)

### Added Permissions:

```xml
<!-- Network permissions -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- Storage permissions -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" android:minSdkVersion="30" />
```

### Permission Details:

| Permission | Purpose | When Required |
|------------|---------|---------------|
| `INTERNET` | Download AI models from internet | Always |
| `ACCESS_NETWORK_STATE` | Check network connectivity status | Always |
| `READ_EXTERNAL_STORAGE` | Read downloaded model files | Always |
| `WRITE_EXTERNAL_STORAGE` | Save downloaded model files | Always |
| `MANAGE_EXTERNAL_STORAGE` | Full storage access on Android 11+ | API 30+ only |

---

## 🍎 **iOS Permissions** (`ios/Runner/Info.plist`)

### Added Permission Descriptions:

```xml
<!-- Permission descriptions -->
<key>NSLocalNetworkUsageDescription</key>
<string>This app requires access to your local network to download and manage AI models</string>
<key>NSBonjourServiceTypes</key>
<array>
  <string>_http._tcp</string>
</array>
```

### Permission Details:

| Key | Purpose | User Prompt |
|-----|---------|-------------|
| `NSLocalNetworkUsageDescription` | Network access for model downloads | "This app requires access to your local network to download and manage AI models" |

---

## 🔧 **Flutter Permission Handling**

### New Service: `PermissionManager` (`lib/services/permission_manager.dart`)

**Features:**
- ✅ **Smart Android Version Detection** - Uses `device_info_plus` to detect Android 11+
- ✅ **Conditional Permission Requests** - Only requests `MANAGE_EXTERNAL_STORAGE` when needed
- ✅ **Graceful Fallback** - Handles permission denials and permanent denials
- ✅ **Settings Navigation** - Opens app settings when permissions are permanently denied

**Key Methods:**
```dart
// Request all permissions at once
Future<Map<Permission, PermissionStatus>> requestAllPermissions()

// Check if storage access is available
Future<bool> hasStoragePermission()

// Request storage permissions with Android version awareness
Future<bool> requestStoragePermission()

// Open settings if permissions permanently denied
Future<bool> openSettingsIfNeeded()
```

---

## 📋 **Updated Code Usage**

### Before (Simple):
```dart
final status = await Permission.storage.request();
if (status.isGranted) {
  // Download model
}
```

### After (Comprehensive):
```dart
final hasPermission = await PermissionManager.requestStoragePermission();
if (!hasPermission) {
  // Try to open settings if permanently denied
  await PermissionManager.openSettingsIfNeeded();
  return;
}
// Download model
```

---

## 🎯 **Android Version Compatibility**

| Android Version | API Level | Permissions Required |
|----------------|-----------|---------------------|
| Android 6-9 | 23-28 | `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE` |
| Android 10 | 29 | `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE` |
| Android 11+ | 30+ | `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE`, `MANAGE_EXTERNAL_STORAGE` |

**Note:** `MANAGE_EXTERNAL_STORAGE` requires user to manually enable "Allow all files access" in app settings on Android 11+.

---

## 🚨 **Permission Request Flow**

1. **Initial Request**: App requests basic storage permissions
2. **Android 11+ Check**: If Android 11+, also request manage external storage
3. **Permission Denied**: Show user-friendly message
4. **Permanently Denied**: Offer to open app settings
5. **Settings Opened**: User must manually enable permissions

---

## 🧪 **Testing Checklist**

### Android Testing:
- [ ] **Android 6-10**: Basic storage permissions work
- [ ] **Android 11+**: Manage external storage requested
- [ ] **Permission Denied**: Graceful error handling
- [ ] **Settings Navigation**: Opens correctly when permanently denied

### iOS Testing:
- [ ] **Network Permission**: Prompt appears on first network access
- [ ] **Permission Text**: User sees clear explanation

### Flutter Testing:
- [ ] **Permission Manager**: All methods work correctly
- [ ] **Model Downloads**: Work with granted permissions
- [ ] **Error Messages**: Clear and actionable

---

## 🔒 **Security Considerations**

- **Minimal Permissions**: Only request what's absolutely necessary
- **Runtime Requests**: Request permissions when actually needed
- **User Education**: Clear explanations for why permissions are needed
- **Fallback Handling**: App works (with limitations) when permissions denied

---

## 📚 **Additional Resources**

- [Android Permissions Guide](https://developer.android.com/guide/topics/permissions/overview)
- [iOS Privacy Manifests](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files)
- [Flutter Permission Handler](https://pub.dev/packages/permission_handler)

---

**Status:** ✅ All permissions configured for Android and iOS
**Compatibility:** Android 6.0+ and iOS 12.0+
**Testing:** Ready for device testing