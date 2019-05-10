import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:amap_base_map/amap_base_map.dart';
import 'package:amap_base_map/src/common/log.dart';
import 'package:amap_base_map/src/map/model/marker_options.dart';
import 'package:amap_base_map/src/map/model/my_location_style.dart';
import 'package:amap_base_map/src/map/model/polygon_options.dart';
import 'package:amap_base_map/src/map/model/polyline_options.dart';
import 'package:amap_base_map/src/map/model/ui_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class AMapController {
  final MethodChannel _mapChannel;
  final EventChannel _markerClickedEventChannel;
  final EventChannel _mapDragEventChannel;

  AMapController.withId(int id)
      : _mapChannel = MethodChannel('me.yohom/map$id'),
        _markerClickedEventChannel = EventChannel('me.yohom/marker_clicked$id'),
        _mapDragEventChannel = EventChannel('me.yohom/map_drag_change');

  void dispose() {}

  /// 设置我的位置
  Future setMyLocationStyle(MyLocationStyle style) {
    final _styleJson =
        jsonEncode(style?.toJson() ?? MyLocationStyle().toJson());

    L.p('方法setMyLocationStyle dart端参数: styleJson -> $_styleJson');
    return _mapChannel.invokeMethod(
      'map#setMyLocationStyle',
      {'myLocationStyle': _styleJson},
    );
  }

  /// 设置控件参数
  Future setUiSettings(UiSettings uiSettings) {
    final _uiSettings = jsonEncode(uiSettings.toJson());

    L.p('方法setUiSettings dart端参数: _uiSettings -> $_uiSettings');
    return _mapChannel.invokeMethod(
      'map#setUiSettings',
      {'uiSettings': _uiSettings},
    );
  }

  /// 添加单个个Marker
  Future addMarker(MarkerOptions options) {
    final _optionsJson = options.toJsonString();
    L.p('方法addMarker dart端参数: _optionsJson -> $_optionsJson');
    return _mapChannel.invokeMethod(
      'marker#addMarker',
      {'markerOptions': _optionsJson},
    );
  }

  /// 添加多个Marker
  Future addMarkers(
    List<MarkerOptions> optionsList, {
    bool moveToCenter = true,
    bool clear = true,
  }) {
    final _optionsListJson =
        jsonEncode(optionsList.map((it) => it.toJson()).toList());
    L.p('方法addMarkers dart端参数: _optionsListJson -> $_optionsListJson');
    return _mapChannel.invokeMethod(
      'marker#addMarkers',
      {
        'moveToCenter': moveToCenter,
        'markerOptionsList': _optionsListJson,
        'clear': clear,
      },
    );
  }

  /// 是否使能室内地图
  Future showIndoorMap(bool enable) {
    return _mapChannel.invokeMethod(
      'map#showIndoorMap',
      {'showIndoorMap': enable},
    );
  }

  /// 设置地图类型
  ///
  /// [mapType]可以为[MAP_TYPE_NORMAL], [MAP_TYPE_SATELLITE], [MAP_TYPE_NIGHT],
  /// [MAP_TYPE_NAVI], [MAP_TYPE_BUS]
  Future setMapType(int mapType) {
    return _mapChannel.invokeMethod(
      'map#setMapType',
      {'mapType': mapType},
    );
  }

  /// 设置语言为[language]
  Future setLanguage(int language) {
    return _mapChannel.invokeMethod(
      'map#setLanguage',
      {'language': language},
    );
  }

  /// 清除marker
  Future clearMarkers() {
    return _mapChannel.invokeMethod('marker#clear');
  }

  /// 清除地图
  Future clearMap() {
    return _mapChannel.invokeMethod('map#clear');
  }

  /// 显示我的位置
  Future showMyLocation(bool show) {
    L.p('showMyLocation dart端参数: show -> $show');

    return _mapChannel.invokeMethod('map#showMyLocation', {'show': show});
  }

  /// 设置缩放等级
  ///
  /// 地图的缩放级别一共分为 17 级，从 3 到 19。数字越大，展示的图面信息越精细
  Future setZoomLevel(int level) {
    L.p('setZoomLevel dart端参数: level -> $level');

    return _mapChannel.invokeMethod(
      'map#setZoomLevel',
      {'zoomLevel': level},
    );
  }

  /// 设置地图中心点
  Future setPosition({
    @required LatLng target,
    double zoom = 10,
    double tilt = 0,
    double bearing = 0,
  }) {
    L.p('setPosition dart端参数: target -> $target, zoom -> $zoom, tilt -> $tilt, bearing -> $bearing');

    return _mapChannel.invokeMethod(
      'map#setPosition',
      {
        'target': target.toJsonString(),
        'zoom': zoom,
        'tilt': tilt,
        'bearing': bearing,
      },
    );
  }

  /// 限制地图的显示范围
  Future setMapStatusLimits({
    /// 西南角 [Android]
    @required LatLng swLatLng,

    /// 东北角 [Android]
    @required LatLng neLatLng,

    /// 中心 [iOS]
    @required LatLng center,

    /// 纬度delta [iOS]
    @required double deltaLat,

    /// 经度delta [iOS]
    @required double deltaLng,
  }) {
    L.p('setPosition dart端参数: swLatLng -> $swLatLng, neLatLng -> $neLatLng, center -> $center, deltaLat -> $deltaLat, deltaLng -> $deltaLng');

    return _mapChannel.invokeMethod(
      'map#setMapStatusLimits',
      {
        'swLatLng': swLatLng.toJsonString(),
        'neLatLng': neLatLng.toJsonString(),
        'center': center.toJsonString(),
        'deltaLat': deltaLat,
        'deltaLng': deltaLng,
      },
    );
  }

  /// 添加线
  Future addPolyline(PolylineOptions options) {
    L.p('addPolyline dart端参数: options -> $options');

    return _mapChannel.invokeMethod(
      'map#addPolyline',
      {'options': options.toJsonString()},
    );
  }

  /// 移动镜头到当前的视角
  Future zoomToSpan(
    List<LatLng> bound, {
    int padding = 80,
  }) {
    final boundJson =
        jsonEncode(bound?.map((it) => it.toJson())?.toList() ?? List());

    L.p('zoomToSpan dart端参数: bound -> $boundJson');

    return _mapChannel.invokeMethod(
      'map#zoomToSpan',
      {
        'bound': boundJson,
        'padding': padding,
      },
    );
  }

  /// 移动指定LatLng到中心
  Future changeLatLng(LatLng target) {
    L.p('changeLatLng dart端参数: target -> $target');

    return _mapChannel.invokeMethod(
      'map#changeLatLng',
      {'target': target.toJsonString()},
    );
  }

  /// 获取中心点
  Future<LatLng> getCenterLatlng() async {
    String result = await _mapChannel.invokeMethod("map#getCenterPoint");
    return LatLng.fromJson(json.decode(result));
  }

  /// 截图
  ///
  /// 可能会抛出 [PlatformException]
  Future<Uint8List> screenShot() async {
    try {
      var result = await _mapChannel.invokeMethod("map#screenshot");
      if (result is List<dynamic>) {
        return Uint8List.fromList(result.map((i) => i as int).toList());
      } else if (result is Uint8List) {
        return result;
      }
      throw PlatformException(code: "不支持的类型");
    } catch (e) {
      if (e is PlatformException) {
        L.d(e.code);
        throw e;
      }
      throw Error();
    }
  }

  /// 设置自定义样式的文件路径
  Future setCustomMapStylePath(String path) {
    L.p('setCustomMapStylePath dart端参数: path -> $path');

    return _mapChannel.invokeMethod(
      'map#setCustomMapStylePath',
      {'path': path},
    );
  }

  /// 使能自定义样式
  Future setMapCustomEnable(bool enabled) {
    L.p('setMapCustomEnable dart端参数: enabled -> $enabled');

    return _mapChannel.invokeMethod(
      'map#setMapCustomEnable',
      {'enabled': enabled},
    );
  }

  /// 使用在线自定义样式
  Future setCustomMapStyleID(String styleId) {
    L.p('setCustomMapStyleID dart端参数: styleId -> $styleId');

    return _mapChannel.invokeMethod(
      'map#setCustomMapStyleID',
      {'styleId': styleId},
    );
  }

  Future addPolygon(PolygonOptions options) {
    L.p('addPolygon dart端参数: options -> ${options.toJsonString()}');

    return _mapChannel.invokeMethod(
      'map#addPolygon',
      {'options': options.toJsonString()},
    );
  }

  /// marker点击事件流
  Stream<MarkerOptions> get markerClickedEvent => _markerClickedEventChannel
      .receiveBroadcastStream()
      .map((data) => MarkerOptions.fromJson(jsonDecode(data)));


  /// 地图拖拽 data: true 结束移动 ；data：false 开始移动
  Stream<LatLng> get mapDragEvent => _mapDragEventChannel
      .receiveBroadcastStream()
      .map((data) => LatLng.fromJson(jsonDecode(data)));
}
