import 'dart:convert';

import 'package:amap_base_map/amap_base_map.dart';

class UiSettings {
  /// 是否允许显示缩放按钮 [Android]
  final bool isZoomControlsEnabled;

  /// 设置缩放按钮的位置 [Android]
  final int zoomPosition;

  /// 指南针 [Android, iOS]
  final bool isCompassEnabled;

  /// 定位按钮 [Android]
  final bool isMyLocationButtonEnabled;

  /// 比例尺控件 [Android, iOS]
  final bool isScaleControlsEnabled;

  /// 地图Logo [Android, iOS暂未实现]
  final int logoPosition;

  /// 缩放手势 [Android, iOS]
  final bool isZoomGesturesEnabled;

  /// 滑动手势 [Android, iOS]
  final bool isScrollGesturesEnabled;

  /// 旋转手势 [Android, iOS]
  final bool isRotateGesturesEnabled;

  /// 倾斜手势 [Android, iOS]
  final bool isTiltGesturesEnabled;

  UiSettings({
    this.isZoomControlsEnabled = true,
    this.zoomPosition = ZOOM_POSITION_RIGHT_BUTTOM,
    this.isCompassEnabled = false,
    this.isMyLocationButtonEnabled = false,
    this.isScaleControlsEnabled = true,
    this.logoPosition = LOGO_POSITION_BOTTOM_LEFT,
    this.isZoomGesturesEnabled = true,
    this.isScrollGesturesEnabled = true,
    this.isRotateGesturesEnabled = true,
    this.isTiltGesturesEnabled = true,
  });

  Map<String, Object> toJson() {
    return {
      'isZoomControlsEnabled': isZoomControlsEnabled,
      'zoomPosition': zoomPosition,
      'isCompassEnabled': isCompassEnabled,
      'isMyLocationButtonEnabled': isMyLocationButtonEnabled,
      'isScaleControlsEnabled': isScaleControlsEnabled,
      'logoPosition': logoPosition,
      'isZoomGesturesEnabled': isZoomGesturesEnabled,
      'isScrollGesturesEnabled': isScrollGesturesEnabled,
      'isRotateGesturesEnabled': isRotateGesturesEnabled,
      'isTiltGesturesEnabled': isTiltGesturesEnabled,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  UiSettings copyWith({
    bool isZoomControlsEnabled,
    int zoomPosition,
    bool isCompassEnabled,
    bool isMyLocationButtonEnabled,
    bool isScaleControlsEnabled,
    int logoPosition,
    bool isZoomGesturesEnabled,
    bool isScrollGesturesEnabled,
    bool isRotateGesturesEnabled,
    bool isTiltGesturesEnabled,
  }) {
    return UiSettings(
      isZoomControlsEnabled:
          isZoomControlsEnabled ?? this.isZoomControlsEnabled,
      zoomPosition: zoomPosition ?? this.zoomPosition,
      isCompassEnabled: isCompassEnabled ?? this.isCompassEnabled,
      isMyLocationButtonEnabled:
          isMyLocationButtonEnabled ?? this.isMyLocationButtonEnabled,
      isScaleControlsEnabled:
          isScaleControlsEnabled ?? this.isScaleControlsEnabled,
      logoPosition: logoPosition ?? this.logoPosition,
      isZoomGesturesEnabled:
          isZoomGesturesEnabled ?? this.isZoomGesturesEnabled,
      isScrollGesturesEnabled:
          isScrollGesturesEnabled ?? this.isScrollGesturesEnabled,
      isRotateGesturesEnabled:
          isRotateGesturesEnabled ?? this.isRotateGesturesEnabled,
      isTiltGesturesEnabled:
          isTiltGesturesEnabled ?? this.isTiltGesturesEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UiSettings &&
          runtimeType == other.runtimeType &&
          isZoomControlsEnabled == other.isZoomControlsEnabled &&
          zoomPosition == other.zoomPosition &&
          isCompassEnabled == other.isCompassEnabled &&
          isMyLocationButtonEnabled == other.isMyLocationButtonEnabled &&
          isScaleControlsEnabled == other.isScaleControlsEnabled &&
          logoPosition == other.logoPosition &&
          isZoomGesturesEnabled == other.isZoomGesturesEnabled &&
          isScrollGesturesEnabled == other.isScrollGesturesEnabled &&
          isRotateGesturesEnabled == other.isRotateGesturesEnabled &&
          isTiltGesturesEnabled == other.isTiltGesturesEnabled;

  @override
  int get hashCode =>
      isZoomControlsEnabled.hashCode ^
      zoomPosition.hashCode ^
      isCompassEnabled.hashCode ^
      isMyLocationButtonEnabled.hashCode ^
      isScaleControlsEnabled.hashCode ^
      logoPosition.hashCode ^
      isZoomGesturesEnabled.hashCode ^
      isScrollGesturesEnabled.hashCode ^
      isRotateGesturesEnabled.hashCode ^
      isTiltGesturesEnabled.hashCode;

  @override
  String toString() {
    return 'UiSettings{isZoomControlsEnabled: $isZoomControlsEnabled, zoomPosition: $zoomPosition, isCompassEnabled: $isCompassEnabled, isMyLocationButtonEnabled: $isMyLocationButtonEnabled, isScaleControlsEnabled: $isScaleControlsEnabled, logoPosition: $logoPosition, isZoomGesturesEnabled: $isZoomGesturesEnabled, isScrollGesturesEnabled: $isScrollGesturesEnabled, isRotateGesturesEnabled: $isRotateGesturesEnabled, isTiltGesturesEnabled: $isTiltGesturesEnabled}';
  }
}
