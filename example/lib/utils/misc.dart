import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const beijing = LatLng(39.90960, 116.397228);
const shanghai = LatLng(31.22, 121.48);
const guangzhou = LatLng(23.16, 113.23);

/// 等待页
Future<T> loading<T>(BuildContext context, Future<T> futureTask) {
  // 是被future pop的还是按返回键pop的
  bool popByFuture = true;

  showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    },
    barrierDismissible: false,
  ).whenComplete(() {
    // 1. 如果是返回键pop的, 那么设置成true, 这样future完成时就不会pop了
    // 2. 如果是future完成导致的pop, 那么这一行是没用任何作用的
    popByFuture = false;
  });
  return futureTask.whenComplete(() {
    // 由于showDialog会强制使用rootNavigator, 所以这里pop的时候也要用rootNavigator
    if (popByFuture) {
      Navigator.of(context, rootNavigator: true).pop(context);
    }
  });
}
