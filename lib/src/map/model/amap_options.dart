import 'dart:convert';

import 'package:amap_base_map/src/map/model/camera_position.dart';

/// 缩放按钮右边界中部
const ZOOM_POSITION_RIGHT_CENTER = 1;

/// 缩放按钮右下
const ZOOM_POSITION_RIGHT_BUTTOM = 2;

/// Logo位置常量（地图左下角）。
const LOGO_POSITION_BOTTOM_LEFT = 0;

/// Logo位置常量（地图底部居中）。
const LOGO_POSITION_BOTTOM_CENTER = 1;

/// Logo位置常量（地图右下角）。
const LOGO_POSITION_BOTTOM_RIGHT = 2;

/// 普通地图
const MAP_TYPE_NORMAL = 1;

/// 卫星地图
const MAP_TYPE_SATELLITE = 2;

/// 黑夜地图
const MAP_TYPE_NIGHT = 3;

/// 导航模式
const MAP_TYPE_NAVI = 4;

/// 公交模式
const MAP_TYPE_BUS = 5;

/// 关于[AMapOptions]:
///   1. 在Android端主要起到一个初始配置MapView的作用, 它里面的所有的设置都能通过[setUiSettings]
///     进行二次设置
///   2. iOS端则不同, iOS端的做法是所有的配置都在[MAMapView]这一个类里, 所以理论上初始化的时候就能
///     够对[MAMapView]做所有的配置
/// 结论:
///   这个类只按照Android端的实现去做两端的初始化配置, 如果iOS端想要其他的配置, 可以通过[AMapController.setUiSettings]
///   去二次设置.
class AMapOptions {
  const AMapOptions({
    this.logoPosition = LOGO_POSITION_BOTTOM_LEFT,
    this.zOrderOnTop = false,
    this.mapType = MAP_TYPE_NORMAL,
    this.camera,
    this.scaleControlsEnabled = false,
    this.zoomControlsEnabled = true,
    this.compassEnabled = false,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.rotateGesturesEnabled = true,
    @Deprecated('在AMapController.setMyLocationStyle中去设置我的位置相关的配置')
        this.myLocationEnabled = false,
  });

  /// “高德地图”Logo的位置 [Android]
  final int logoPosition;
  final bool zOrderOnTop;

  /// 地图模式 [Android, iOS]
  final int mapType;

  /// 地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。 [Android全部有效, iOS部分有效]
  final CameraPosition camera;

  /// 比例尺功能是否可用 [Android, iOS]
  final bool scaleControlsEnabled;

  /// 地图是否允许缩放 [Android]
  final bool zoomControlsEnabled;

  /// 指南针是否可用。 [Android, iOS]
  final bool compassEnabled;

  /// 拖动手势是否可用 [Android, iOS]
  final bool scrollGesturesEnabled;

  /// 缩放手势是否可用 [Android, iOS]
  final bool zoomGesturesEnabled;

  /// 地图倾斜手势（显示3D效果）是否可用 [Android]
  final bool tiltGesturesEnabled;

  /// 地图旋转手势是否可用 [Android, iOS]
  final bool rotateGesturesEnabled;

  /// 是否启动显示定位蓝点, 默认false [Android]
  @Deprecated('在AMapController.setMyLocationStyle中去设置我的位置相关的配置')
  final bool myLocationEnabled;

  Map<String, Object> toJson() {
    return {
      'logoPosition': logoPosition,
      'zOrderOnTop': zOrderOnTop,
      'mapType': mapType,
      'camera': camera?.toJson(),
      'scaleControlsEnabled': scaleControlsEnabled,
      'zoomControlsEnabled': zoomControlsEnabled,
      'compassEnabled': compassEnabled,
      'scrollGesturesEnabled': scrollGesturesEnabled,
      'zoomGesturesEnabled': zoomGesturesEnabled,
      'tiltGesturesEnabled': tiltGesturesEnabled,
      'rotateGesturesEnabled': rotateGesturesEnabled,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  AMapOptions copyWith({
    int logoPosition,
    bool zOrderOnTop,
    int mapType,
    CameraPosition camera,
    bool scaleControlsEnabled,
    bool zoomControlsEnabled,
    bool compassEnabled,
    bool scrollGesturesEnabled,
    bool zoomGesturesEnabled,
    bool tiltGesturesEnabled,
    bool rotateGesturesEnabled,
    bool myLocationEnabled,
  }) {
    return AMapOptions(
      logoPosition: logoPosition ?? this.logoPosition,
      zOrderOnTop: zOrderOnTop ?? this.zOrderOnTop,
      mapType: mapType ?? this.mapType,
      camera: camera ?? this.camera,
      scaleControlsEnabled: scaleControlsEnabled ?? this.scaleControlsEnabled,
      zoomControlsEnabled: zoomControlsEnabled ?? this.zoomControlsEnabled,
      compassEnabled: compassEnabled ?? this.compassEnabled,
      scrollGesturesEnabled:
          scrollGesturesEnabled ?? this.scrollGesturesEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled ?? this.zoomGesturesEnabled,
      tiltGesturesEnabled: tiltGesturesEnabled ?? this.tiltGesturesEnabled,
      rotateGesturesEnabled:
          rotateGesturesEnabled ?? this.rotateGesturesEnabled,
      myLocationEnabled: myLocationEnabled ?? this.myLocationEnabled,
    );
  }

  @override
  String toString() {
    return 'AMapOptions{logoPosition: $logoPosition, zOrderOnTop: $zOrderOnTop, mapType: $mapType, camera: $camera, scaleControlsEnabled: $scaleControlsEnabled, zoomControlsEnabled: $zoomControlsEnabled, compassEnabled: $compassEnabled, scrollGesturesEnabled: $scrollGesturesEnabled, zoomGesturesEnabled: $zoomGesturesEnabled, tiltGesturesEnabled: $tiltGesturesEnabled, rotateGesturesEnabled: $rotateGesturesEnabled, myLocationEnabled: $myLocationEnabled}';
  }
}
