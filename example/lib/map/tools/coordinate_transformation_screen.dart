import 'package:amap_base_example/utils/log.dart';
import 'package:amap_base_example/widgets/dimens.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class CoordinateTransformationScreen extends StatefulWidget {
  @override
  _CoordinateTransformationStateScreen createState() =>
      _CoordinateTransformationStateScreen();
}

class _CoordinateTransformationStateScreen
    extends State<CoordinateTransformationScreen> {
  final _lat = 39.914266;
  final _lon = 116.403988;

  final _latController = TextEditingController(text: "39.914266");
  final _lngController = TextEditingController(text: "116.403988");

  LatLngType type = LatLngType.baidu;

  LatLng current = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _latController.addListener(update);
    _lngController.addListener(update);
  }

  void update() {
    CalculateTools()
        .convertCoordinate(
      lat: _lat,
      lon: _lon,
      type: type,
    )
        .then((result) {
      L.p('result: $result');
      setState(() => this.current = result);
    });
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('坐标转换'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SPACE_NORMAL,
            TextFormField(
              controller: _latController,
              decoration: InputDecoration(
                labelText: "纬度 latitude",
                border: OutlineInputBorder(),
              ),
              enabled: false,
            ),
            SPACE_NORMAL,
            TextFormField(
              controller: _lngController,
              decoration: InputDecoration(
                labelText: "经度 longitude",
                border: OutlineInputBorder(),
              ),
              enabled: false,
            ),
            SPACE_NORMAL,
            DropdownButtonFormField(
              items: LatLngType.values.map((type) => _buildItem(type)).toList(),
              value: type,
              onChanged: (type) {
                this.type = type;
                update();
              },
            ),
            SPACE_NORMAL,
            Text("转换后坐标: " + (current?.toString() ?? "")),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<LatLngType> _buildItem(LatLngType type) {
    return DropdownMenuItem(
      child: Text(type.toString()),
      value: type,
    );
  }
}
