import 'package:amap_base_example/map/map.screen.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

void main() async {
  await AMap.init('27d67839721288be2ddd87b4fd868822');
  runApp(MaterialApp(home: LauncherScreen()));
}

class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AMaps examples'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: MapDemo(),
    );
  }
}
