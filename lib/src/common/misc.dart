import 'dart:collection';
import 'dart:io';

import 'package:amap_base_map/amap_base_map.dart';
import 'package:amap_base_map/src/common/log.dart';
import 'package:flutter/material.dart';

double devicePixelRatio = 1;

bool isEmpty(Object object) {
  if (object == null) {
    return true;
  }

  if (object is String) {
    return object.isEmpty;
  }

  if (object is Iterable) {
    return object.isEmpty;
  }

  if (object is Map) {
    return object.isEmpty;
  }

  return false;
}

bool isNotEmpty(Object object) {
  return !isEmpty(object);
}

bool isAllEmpty(List<Object> list) {
  if (isEmpty(list)) {
    return true;
  } else {
    return list.every(isEmpty);
  }
}

bool isAllNotEmpty(List<Object> list) {
  if (isEmpty(list)) {
    return false;
  }
  return !list.any(isEmpty);
}

String toResolutionAware(String assetName) {
  final RegExp _extractRatioRegExp = RegExp(r'/?(\d+(\.\d*)?)x$');
  const double _naturalResolution = 1.0;

  double _parseScale(String key) {
    if (key == assetName) {
      return _naturalResolution;
    }

    final File assetPath = File(key);
    final Directory assetDir = assetPath.parent;

    final Match match = _extractRatioRegExp.firstMatch(assetDir.path);
    if (match != null && match.groupCount > 0)
      return double.parse(match.group(1));
    return _naturalResolution; // i.e. default to 1.0x
  }

  String _findNearest(SplayTreeMap<double, String> candidates, double value) {
    if (candidates.containsKey(value)) return candidates[value];
    final double lower = candidates.lastKeyBefore(value);
    final double upper = candidates.firstKeyAfter(value);
    if (lower == null) return candidates[upper];
    if (upper == null) return candidates[lower];
    if (value > (lower + upper) / 2)
      return candidates[upper];
    else
      return candidates[lower];
  }

  String _chooseVariant(
    String main,
    ImageConfiguration config,
    List<String> candidates,
  ) {
    if (config.devicePixelRatio == null ||
        candidates == null ||
        candidates.isEmpty) return main;
    final SplayTreeMap<double, String> mapping = SplayTreeMap<double, String>();
    for (String candidate in candidates)
      mapping[_parseScale(candidate)] = candidate;
    return _findNearest(mapping, config.devicePixelRatio);
  }

  final String chosenName = _chooseVariant(
      assetName,
      ImageConfiguration(devicePixelRatio: devicePixelRatio),
      AMap.assetManifest == null ? null : AMap.assetManifest[assetName]);
  L.p('设备devicePixelRatio: $devicePixelRatio, 选中的图片: $chosenName');
  return chosenName;
}
