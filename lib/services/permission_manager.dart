import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionManager {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Request all necessary permissions for the app
  static Future<Map<Permission, PermissionStatus>>
  requestAllPermissions() async {
    final permissions = [Permission.storage];

    // Add manage external storage for Android 11+
    if (await _isAndroid11OrHigher()) {
      permissions.add(Permission.manageExternalStorage);
    }

    final Map<Permission, PermissionStatus> results = {};

    for (final permission in permissions) {
      final status = await permission.request();
      results[permission] = status;
    }

    return results;
  }

  /// Check if storage permissions are granted
  static Future<bool> hasStoragePermission() async {
    final storageStatus = await Permission.storage.status;

    if (await _isAndroid11OrHigher()) {
      final manageStorageStatus = await Permission.manageExternalStorage.status;
      return storageStatus.isGranted && manageStorageStatus.isGranted;
    }

    return storageStatus.isGranted;
  }

  /// Request storage permissions specifically
  static Future<bool> requestStoragePermission() async {
    // First try the basic storage permission
    var storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
      // On Android 11+, also try to get manage external storage permission
      if (await _isAndroid11OrHigher()) {
        final manageStatus = await Permission.manageExternalStorage.request();
        return manageStatus.isGranted;
      }
      return true;
    }

    return false;
  }

  /// Check if running on Android 11 or higher (API 30+)
  static Future<bool> _isAndroid11OrHigher() async {
    try {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 30;
    } catch (e) {
      // If we can't get device info, assume Android 11+ for safety
      return true;
    }
  }

  /// Open app settings if permissions are permanently denied
  static Future<bool> openSettingsIfNeeded() async {
    final storageStatus = await Permission.storage.status;

    if (storageStatus.isPermanentlyDenied) {
      return await openAppSettings();
    }

    if (await _isAndroid11OrHigher()) {
      final manageStatus = await Permission.manageExternalStorage.status;
      if (manageStatus.isPermanentlyDenied) {
        return await openAppSettings();
      }
    }

    return false;
  }
}
