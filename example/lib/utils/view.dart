import 'dart:async';

import 'package:amap_base_example/utils/enums.dart';
import 'package:amap_base_example/utils/log.dart';
import 'package:flutter/material.dart';

/// 显示信息底层方法, 当需要动态选择是错误还是正常信息时, 调用这个方法
Future<SnackBarClosedReason> showMessage(
  BuildContext context,
  String content, {
  ErrorLevel errorLevel = ErrorLevel.none,
  bool isExit = false, // show完了是否退出本页
  Type exitTo, // 退出到对应页面
  Duration duration = const Duration(milliseconds: 1500),
}) {
  L.d('messge: $content');
  Color color;
  switch (errorLevel) {
    case ErrorLevel.none:
      break;
    case ErrorLevel.warn:
      color = Colors.yellowAccent;
      break;
    case ErrorLevel.severe:
    case ErrorLevel.fatal:
      color = Colors.red;
      break;
  }
  return Scaffold.of(context)
      .showSnackBar(
        SnackBar(
          content: Text(content),
          backgroundColor: color,
          duration: duration,
        ),
      )
      .closed
      .then((_) {});
}

/// 显示错误信息
Future<SnackBarClosedReason> showError(
  BuildContext context,
  String content, {
  bool isExit = false, // show完了是否退出本页
  Type exitTo, // 退出到对应页面
  Duration duration = const Duration(milliseconds: 1500),
}) {
  return showMessage(
    context,
    content,
    errorLevel: ErrorLevel.severe,
    isExit: isExit,
    exitTo: exitTo,
    duration: duration,
  );
}

/// 显示普通信息
Future<SnackBarClosedReason> showInfo(
  BuildContext context,
  String content, {
  bool isExit = false, // show完了是否退出本页
  Type exitTo, // 退出到对应页面
  Duration duration = const Duration(milliseconds: 1500),
}) {
  return showMessage(
    context,
    content,
    errorLevel: ErrorLevel.none,
    isExit: isExit,
    exitTo: exitTo,
    duration: duration,
  );
}

/// 显示警告信息
Future<SnackBarClosedReason> showWarn(
  BuildContext context,
  String content, {
  bool isExit = false, // show完了是否退出本页
  Type exitTo, // 退出到对应页面
  Duration duration = const Duration(milliseconds: 1500),
}) {
  return showMessage(
    context,
    content,
    errorLevel: ErrorLevel.warn,
    isExit: isExit,
    exitTo: exitTo,
    duration: duration,
  );
}
