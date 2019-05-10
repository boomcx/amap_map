import 'package:flutter/services.dart';

class OfflineManager {
  static OfflineManager _instance;

  static const _channel = MethodChannel('me.yohom/offline');

  OfflineManager._();

  factory OfflineManager() {
    if (_instance == null) {
      _instance = OfflineManager._();
      return _instance;
    } else {
      return _instance;
    }
  }

  /// 打开离线地图管理页
  Future openOfflineManager() {
    return _channel.invokeMethod('offline#openOfflineManager');
  }
}
