import 'package:carenest/app/core/utils/media_store_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionHandler {
  Future<bool> checkAndRequestStoragePermission() async {
    List<Permission> permissions = [
      Permission.manageExternalStorage,
    ];

    if ((await mediaStorePlugin.getPlatformSDKInt()) >= 33) {
      permissions.add(Permission.manageExternalStorage);
      // permissions.add(Permission.audio);
      // permissions.add(Permission.videos);
    }

    var permissionStatus = await permissions.request();

    // Check if all permissions are granted
    late bool allPermissionsGranted;
    permissionStatus.forEach((key, status) {
      if (!status.isGranted) {
        allPermissionsGranted = false;
      } else {
        allPermissionsGranted = true;
      }
    });

    return allPermissionsGranted;
  }
}
