import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class CalcuteDistanceScreen extends StatefulWidget {
  @override
  CcalcuteDistanceStateScreen createState() => CcalcuteDistanceStateScreen();
}

class CcalcuteDistanceStateScreen extends State<CalcuteDistanceScreen> {
  AMapController _controller;

  LatLng latlng1;
  LatLng latlng2;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('距离计算'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: AMapView(
              onAMapViewCreated: (controller) async {
                _controller = controller;
                await controller.showIndoorMap(true);
                await controller.setZoomLevel(19);

                initEvent();
              },
              amapOptions: AMapOptions(),
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                _buildRow('坐标1', latlng1, (lng) {
                  this.latlng1 = lng;
                }),
                _buildRow('坐标2', latlng2, (lng) {
                  this.latlng2 = lng;
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDistance(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initEvent() {
    // _controller?.
  }

  Widget _buildRow(
    String title,
    LatLng latlng,
    ValueSetter<LatLng> setter,
  ) {
    String text;
    if (latlng == null) {
      text = "请先获取坐标值";
    } else {
      text =
          "${latlng.latitude.toStringAsFixed(5)},${latlng.longitude.toStringAsFixed(5)}";
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(title),
          Row(
            children: <Widget>[
              Text(text),
              Container(width: 10.0),
              RaisedButton(
                child: Text('获取$title'),
                onPressed: () async {
                  var center = await _controller?.getCenterLatlng();
                  if (center != null) {
                    setter(center);
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget _buildDistance() {
    if (latlng1 == null || latlng2 == null) {
      return Text("请先获取坐标");
    }
    return FutureBuilder<double>(
      future: CalculateTools().calcDistance(latlng1, latlng2),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Text("两点间的距离为 ${snapshot.data.toStringAsFixed(2)} 米");
        }
        return Text("请先获取坐标");
      },
    );
  }
}
