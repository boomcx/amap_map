import 'dart:convert';
import 'dart:ui';

import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const LINE_DASH_TYPE_NONE = 0;
const LINE_DASH_TYPE_SQUARE = 1;
const LINE_DASH_TYPE_DOT = 2;

class PolygonOptions {
  /// 多边形边框的顶点 [Android, iOS]
  final List<LatLng> points;

  /// 多边形的边框宽度 [Android, iOS]
  final double strokeWidth;

  /// 多边形的边框颜色 32位ARGB格式 [Android, iOS]
  final Color strokeColor;

  /// 多边形的填充颜色，32位ARGB格式 [Android, iOS]
  final Color fillColor;

  /// 多边形的Z轴数值 [Android]
  final int zIndex;

  /// 多边形是否可见 [Android]
  final bool visible;

  /// 空心洞的配置项 [Android]
  final List<BaseHoleOptions> holeOptions;

  /// LineJoin,默认是kMALineJoinBevel [iOS]
  final int lineJoinType;

  /// LineCap,默认是kMALineCapButt [iOS]
  final int lineCapType;

  /// MiterLimit,默认是10.f [iOS]
  final double miterLimit;

  /// 虚线类型 [iOS]
  final int lineDashType;

  PolygonOptions({
    @required this.points,
    this.strokeWidth = 1,
    this.strokeColor = Colors.black,
    this.fillColor = Colors.black,
    this.zIndex = 0,
    this.visible = true,
    this.holeOptions = const [],
    this.lineJoinType = LINE_JOIN_BEVEL,
    this.lineCapType = LINE_CAP_TYPE_BUTT,
    this.miterLimit = 10.0,
    this.lineDashType = LINE_DASH_TYPE_SQUARE,
  });

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'strokeWidth': strokeWidth,
      'strokeColor': strokeColor.value.toRadixString(16),
      'fillColor': fillColor.value.toRadixString(16),
      'zIndex': zIndex,
      'visible': visible,
      'holeOptions': holeOptions
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'PolygonOptions{points: $points, strokeWidth: $strokeWidth, strokeColor: $strokeColor, fillColor: $fillColor, zIndex: $zIndex, visible: $visible, holeOptions: $holeOptions}';
  }
}

class BaseHoleOptions {}
