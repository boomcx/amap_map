import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

/// 定位、且将视角移动到地图中心点，定位点跟随设备移动
const LOCATION_TYPE_FOLLOW = 2;

/// 定位、但不会移动到地图中心点，并且会跟随设备移动
const LOCATION_TYPE_FOLLOW_NO_CENTER = 6;

/// 定位、且将视角移动到地图中心点
const LOCATION_TYPE_LOCATE = 1;

/// 定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动
const LOCATION_TYPE_LOCATION_ROTATE = 4;

/// 定位、但不会移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动
const LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER = 5;

/// 定位、且将视角移动到地图中心点，地图依照设备方向旋转，定位点会跟随设备移动
const LOCATION_TYPE_MAP_ROTATE = 3;

/// 定位、但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动
const LOCATION_TYPE_MAP_ROTATE_NO_CENTER = 7;

/// 只定位
const LOCATION_TYPE_SHOW = 0;

class MyLocationStyle {
  /// 当前位置的图标 [Android暂不支持, iOS暂不支持]
  final String myLocationIcon;

  /// 锚点横坐标方向的偏移量 [Android]
  final double anchorU;

  /// 锚点纵坐标方向的偏移量 [Android]
  final double anchorV;

  /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值 [Android, iOS]
  final Color radiusFillColor;

  /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值 [Android, iOS]
  final Color strokeColor;

  /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度 [Android, iOS]
  final double strokeWidth;

  /// 我的位置展示模式
  final int myLocationType;

  /// 定位请求时间间隔 [Android]
  final int interval;

  /// 是否显示定位小蓝点 [Android]
  final bool showMyLocation;

  /// 精度圈是否显示，默认YES [iOS]
  final bool showsAccuracyRing;

  /// 是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES [iOS]
  final bool showsHeadingIndicator;

  /// 定位点背景色，不设置默认白色 [iOS]
  final Color locationDotBgColor;

  /// 定位点蓝色圆点颜色，不设置默认蓝色 [iOS]
  final Color locationDotFillColor;

  /// 内部蓝色圆点是否使用律动效果, 默认YES [iOS]
  final bool enablePulseAnimation;

  MyLocationStyle({
    this.myLocationIcon,
    this.anchorU = 0.5,
    this.anchorV = 0.5,
    this.radiusFillColor = Colors.transparent,
    this.strokeColor = Colors.transparent,
    this.strokeWidth = 1,
    this.myLocationType = LOCATION_TYPE_LOCATION_ROTATE,
    this.interval = 2000,
    this.showMyLocation = true,
    this.showsAccuracyRing = true,
    this.showsHeadingIndicator = false,
    this.locationDotBgColor = Colors.white,
    this.locationDotFillColor = Colors.blue,
    this.enablePulseAnimation = true,
  });

  Map<String, Object> toJson() {
    return {
      'myLocationIcon': myLocationIcon,
      'anchorU': anchorU,
      'anchorV': anchorV,
      'radiusFillColor': radiusFillColor.value.toRadixString(16),
      'strokeColor': strokeColor.value.toRadixString(16),
      'strokeWidth': strokeWidth,
      'myLocationType': myLocationType,
      'interval': interval,
      'showMyLocation': showMyLocation,
      'showsAccuracyRing': showsAccuracyRing,
      'showsHeadingIndicator': showsHeadingIndicator,
      'locationDotBgColor': locationDotBgColor.value.toRadixString(16),
      'locationDotFillColor': locationDotFillColor.value.toRadixString(16),
      'enablePulseAnnimation': enablePulseAnimation,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  MyLocationStyle copyWith({
    String myLocationIcon,
    double anchorU,
    double anchorV,
    Color radiusFillColor,
    Color strokeColor,
    double strokeWidth,
    int myLocationType,
    int interval,
    bool showMyLocation,
    bool showsAccuracyRing,
    bool showsHeadingIndicator,
    Color locationDotBgColor,
    Color locationDotFillColor,
    bool enablePulseAnimation,
  }) {
    return MyLocationStyle(
      myLocationIcon: myLocationIcon ?? this.myLocationIcon,
      anchorU: anchorU ?? this.anchorU,
      anchorV: anchorV ?? this.anchorV,
      radiusFillColor: radiusFillColor ?? this.radiusFillColor,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      myLocationType: myLocationType ?? this.myLocationType,
      interval: interval ?? this.interval,
      showMyLocation: showMyLocation ?? this.showMyLocation,
      showsAccuracyRing: showsAccuracyRing ?? this.showsAccuracyRing,
      showsHeadingIndicator:
          showsHeadingIndicator ?? this.showsHeadingIndicator,
      locationDotBgColor: locationDotBgColor ?? this.locationDotBgColor,
      locationDotFillColor: locationDotFillColor ?? this.locationDotFillColor,
      enablePulseAnimation: enablePulseAnimation ?? this.enablePulseAnimation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyLocationStyle &&
          runtimeType == other.runtimeType &&
          myLocationIcon == other.myLocationIcon &&
          anchorU == other.anchorU &&
          anchorV == other.anchorV &&
          radiusFillColor == other.radiusFillColor &&
          strokeColor == other.strokeColor &&
          strokeWidth == other.strokeWidth &&
          myLocationType == other.myLocationType &&
          interval == other.interval &&
          showMyLocation == other.showMyLocation &&
          showsAccuracyRing == other.showsAccuracyRing &&
          showsHeadingIndicator == other.showsHeadingIndicator &&
          locationDotBgColor == other.locationDotBgColor &&
          locationDotFillColor == other.locationDotFillColor &&
          enablePulseAnimation == other.enablePulseAnimation;

  @override
  int get hashCode =>
      myLocationIcon.hashCode ^
      anchorU.hashCode ^
      anchorV.hashCode ^
      radiusFillColor.hashCode ^
      strokeColor.hashCode ^
      strokeWidth.hashCode ^
      myLocationType.hashCode ^
      interval.hashCode ^
      showMyLocation.hashCode ^
      showsAccuracyRing.hashCode ^
      showsHeadingIndicator.hashCode ^
      locationDotBgColor.hashCode ^
      locationDotFillColor.hashCode ^
      enablePulseAnimation.hashCode;

  @override
  String toString() {
    return 'MyLocationStyle{myLocationIcon: $myLocationIcon, anchorU: $anchorU, anchorV: $anchorV, radiusFillColor: $radiusFillColor, strokeColor: $strokeColor, strokeWidth: $strokeWidth, myLocationType: $myLocationType, interval: $interval, showMyLocation: $showMyLocation, showsAccuracyRing: $showsAccuracyRing, showsHeadingIndicator: $showsHeadingIndicator, locationDotBgColor: $locationDotBgColor, locationDotFillColor: $locationDotFillColor, enablePulseAnimation: $enablePulseAnimation}';
  }
}
