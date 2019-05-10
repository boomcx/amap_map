import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

const polygonList = const [
  LatLng(39.999391, 116.135972),
  LatLng(39.898323, 116.057694),
  LatLng(39.900430, 116.265061),
  LatLng(39.955192, 116.140092),
];

class DrawPolygonScreen extends StatefulWidget {
  DrawPolygonScreen();

  factory DrawPolygonScreen.forDesignTime() => DrawPolygonScreen();

  @override
  _DrawPolygonScreenState createState() => _DrawPolygonScreenState();
}

class _DrawPolygonScreenState extends State<DrawPolygonScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制多边形'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller;
          loading(
            context,
            controller.addPolygon(
              PolygonOptions(
                points: polygonList,
                strokeWidth: 10,
                strokeColor: Colors.black,
                fillColor: Colors.blueAccent,
              ),
            ),
          ).catchError((e) => showError(context, e.toString()));
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
