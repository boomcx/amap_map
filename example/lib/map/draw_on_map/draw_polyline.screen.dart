import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/utils/view.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

const polylineList = const [
  LatLng(39.999391, 116.135972),
  LatLng(39.898323, 116.057694),
  LatLng(39.900430, 116.265061),
  LatLng(39.955192, 116.140092),
];

class DrawPolylineScreen extends StatefulWidget {
  DrawPolylineScreen();

  factory DrawPolylineScreen.forDesignTime() => DrawPolylineScreen();

  @override
  _DrawPolylineScreenState createState() => _DrawPolylineScreenState();
}

class _DrawPolylineScreenState extends State<DrawPolylineScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制线'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller..setZoomLevel(10);
          loading(
            context,
            controller.addPolyline(
              PolylineOptions(
                latLngList: polylineList,
                color: Colors.red,
                isDottedLine: true,
                isGeodesic: true,
                dottedLineType: DOTTED_LINE_TYPE_CIRCLE,
                width: 10,
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
