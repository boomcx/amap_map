import 'dart:convert';
import 'dart:ui';

import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const DOTTED_LINE_TYPE_CIRCLE = 1;
const DOTTED_LINE_TYPE_SQUARE = 0;

const LINE_CAP_TYPE_BUTT = 0;
const LINE_CAP_TYPE_SQUARE = 1;
const LINE_CAP_TYPE_ARROW = 2;
const LINE_CAP_TYPE_ROUND = 3;

const LINE_JOIN_BEVEL = 0;
const LINE_JOIN_MITER = 1;
const LINE_JOIN_ROUND = 2;

class PolylineOptions {
  /// 顶点 [Android, iOS]
  final List<LatLng> latLngList;

  /// 线段的宽度 [Android, iOS]
  final double width;

  /// 线段的颜色 [Android, iOS]
  final Color color;

  /// 线段的Z轴值 [Android]
  final double zIndex;

  /// 线段的可见属性 [Android]
  final bool isVisible;

  /// 线段是否画虚线，默认为false，画实线 [Android, iOS]
  final bool isDottedLine;

  /// 线段是否为大地曲线，默认false，不画大地曲线 [Android]
  final bool isGeodesic;

  /// 虚线形状 [Android, iOS]
  final int dottedLineType;

  /// Polyline尾部形状 [Android, iOS]
  final int lineCapType;

  /// Polyline连接处形状 [Android, iOS]
  final int lineJoinType;

  /// 线段是否使用渐变色 [Android]
  final bool isUseGradient;

  /// 线段是否使用纹理贴图 [Android]
  final bool isUseTexture;

  PolylineOptions({
    @required this.latLngList,
    @required this.width,
    this.color = Colors.black,
    this.zIndex = 0,
    this.isVisible = true,
    this.isDottedLine = false,
    this.isGeodesic = false,
    this.dottedLineType = DOTTED_LINE_TYPE_SQUARE,
    this.lineCapType = LINE_CAP_TYPE_BUTT,
    this.lineJoinType = LINE_JOIN_BEVEL,
    this.isUseGradient = false,
    this.isUseTexture = false,
  });

  Map<String, Object> toJson() {
    return {
      'latLngList': latLngList?.map((it) => it.toJson())?.toList() ?? List(),
      'width': width,
      'color': color.value.toRadixString(16),
      'zIndex': zIndex,
      'isVisible': isVisible,
      'isDottedLine': isDottedLine,
      'isGeodesic': isGeodesic,
      'dottedLineType': dottedLineType,
      'lineCapType': lineCapType,
      'lineJoinType': lineJoinType,
      'isUseGradient': isUseGradient,
      'isUseTexture': isUseTexture,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() {
    return 'PolylineOptions{latLngList: $latLngList, width: $width, color: $color, zIndex: $zIndex, isVisible: $isVisible, isDottedLine: $isDottedLine, isGeodesic: $isGeodesic, dottedLineType: $dottedLineType, lineCapType: $lineCapType, lineJoinType: $lineJoinType, isUseGradient: $isUseGradient, isUseTexture: $isUseTexture}';
  }
}
