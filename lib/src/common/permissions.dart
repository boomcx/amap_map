import 'package:flutter/services.dart';

class Permissions {
  static Permissions _instance;

  static const _permissionChannel = MethodChannel('me.yohom/permission');

  Permissions._();

  factory Permissions() {
    if (_instance == null) {
      _instance = Permissions._();
      return _instance;
    } else {
      return _instance;
    }
  }

  /// 请求地图相关权限
  Future<bool> requestPermission() {
    return _permissionChannel
        .invokeMethod('requestPermission')
        .then((result) => result as bool);
  }
}
