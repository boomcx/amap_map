import 'package:amap_base_example/utils/misc.dart';
import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class CodeInteractionScreen extends StatefulWidget {
  CodeInteractionScreen();

  factory CodeInteractionScreen.forDesignTime() => CodeInteractionScreen();

  @override
  _CodeInteractionScreenState createState() => _CodeInteractionScreenState();
}

class _CodeInteractionScreenState extends State<CodeInteractionScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('调用方法交互'),
        backgroundColor: Colors.black,
        centerTitle: true,
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
          Flexible(
            child: ListView(
              children: <Widget>[
                DiscreteSetting(
                  head: '改变地图的中心点',
                  options: ['北京', '上海', '广州'],
                  onSelected: (value) {
                    LatLng location;
                    switch (value) {
                      case '北京':
                        location = beijing;
                        break;
                      case '上海':
                        location = shanghai;
                        break;
                      case '广州':
                        location = guangzhou;
                        break;
                    }
                    _controller?.setPosition(target: location);
                  },
                ),
                ContinuousSetting(
                  head: '改变地图的缩放级别',
                  max: 19,
                  onChanged: (value) {
                    _controller.setZoomLevel(value.toInt());
                  },
                ),
                BooleanSetting(
                  head: '限制地图的显示范围',
                  onSelected: (value) {
                    if (value) {
                      _controller.setMapStatusLimits(
                        swLatLng: LatLng(33.789925, 104.838326),
                        neLatLng: LatLng(38.740688, 114.647472),
                        center: beijing,
                        deltaLat: 2,
                        deltaLng: 2,
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
