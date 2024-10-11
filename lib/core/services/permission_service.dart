import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._();

  PermissionService._();

  factory PermissionService() {
    return _instance;
  }

  Future<bool> hasAnyPermissionDenied(List<Permission> permissions) async {
    for (var i = 0; i < permissions.length; i++) {
      var status = await permissions[i].status;

      if (!status.isGranted) {
        return true;
      }
    }

    return false;
  }

  Future<bool> requestPermissions(List<Permission> permissions) async {
    var statuses = await permissions.request();

    var hasAnyDenied = statuses.values
        .toList()
        .any((status) => status != PermissionStatus.granted);

    if (hasAnyDenied) {
      return false;
    }

    return true;
  }
}
