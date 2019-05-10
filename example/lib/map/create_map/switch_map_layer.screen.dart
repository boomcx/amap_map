import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class SwitchMapLayerScreen extends StatefulWidget {
  SwitchMapLayerScreen();

  factory SwitchMapLayerScreen.forDesignTime() => SwitchMapLayerScreen();

  @override
  _SwitchMapLayerScreenState createState() => _SwitchMapLayerScreenState();
}

class _SwitchMapLayerScreenState extends State<SwitchMapLayerScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('显示地图'),
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
                  head: '地图图层 [Android, iOS]',
                  options: [
                    '导航地图',
                    '夜景地图',
                    '白昼地图（即普通地图）',
                    '卫星图',
                  ],
                  onSelected: (value) {
                    int mapType;
                    switch (value) {
                      case '导航地图':
                        mapType = MAP_TYPE_NAVI;
                        break;
                      case '夜景地图':
                        mapType = MAP_TYPE_NIGHT;
                        break;
                      case '白昼地图（即普通地图）':
                        mapType = MAP_TYPE_NORMAL;
                        break;
                      case '卫星图':
                        mapType = MAP_TYPE_SATELLITE;
                        break;
                    }
                    _controller.setMapType(mapType);
                  },
                ),
              ],
            ),
          ),
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
