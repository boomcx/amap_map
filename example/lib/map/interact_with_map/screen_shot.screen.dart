import 'dart:typed_data';

import 'package:amap_base_example/widgets/dimens.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class ScreenShotScreen extends StatefulWidget {
  @override
  _ScreenShotScreenState createState() => _ScreenShotScreenState();
}

class _ScreenShotScreenState extends State<ScreenShotScreen> {
  AMapController _controller;

  Uint8List imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('截图'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: AMapView(
              onAMapViewCreated: (controller) {
                setState(() => _controller = controller);
              },
              amapOptions: AMapOptions(),
            ),
          ),
          SPACE_BIG,
          Flexible(
            child: imageData == null ? Container() : Image.memory(imageData),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _screenshot,
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void _screenshot() async {
    var u8List = await _controller.screenShot();
    if (u8List != null) {
      setState(() {
        this.imageData = u8List;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
