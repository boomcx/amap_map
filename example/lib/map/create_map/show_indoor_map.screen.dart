import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class ShowsIndoorMapScreen extends StatefulWidget {
  ShowsIndoorMapScreen();

  factory ShowsIndoorMapScreen.forDesignTime() => ShowsIndoorMapScreen();

  @override
  ShowsIndoorMapScreenState createState() => ShowsIndoorMapScreenState();
}

class ShowsIndoorMapScreenState extends State<ShowsIndoorMapScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('显示室内地图'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: AMapView(
        onAMapViewCreated: (controller) async {
          _controller = controller;
          await controller.showIndoorMap(true);
          await controller.setZoomLevel(19);
        },
        amapOptions: AMapOptions(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
