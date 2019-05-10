import 'package:amap_base_example/widgets/setting.widget.dart';
import 'package:amap_base_map/amap_base_map.dart';
import 'package:flutter/material.dart';

class GestureInteractionScreen extends StatefulWidget {
  GestureInteractionScreen();

  factory GestureInteractionScreen.forDesignTime() =>
      GestureInteractionScreen();

  @override
  _GestureInteractionScreenState createState() =>
      _GestureInteractionScreenState();
}

class _GestureInteractionScreenState extends State<GestureInteractionScreen> {
  AMapController _controller;
  UiSettings _uiSettings = UiSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势交互'),
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
                BooleanSetting(
                  head: '缩放手势 [Android, iOS]',
                  selected: true,
                  onSelected: (value) {
                    _uiSettings =
                        _uiSettings.copyWith(isZoomGesturesEnabled: value);
                    _controller?.setUiSettings(_uiSettings);
                  },
                ),
                BooleanSetting(
                  head: '滑动手势 [Android, iOS]',
                  selected: true,
                  onSelected: (value) {
                    _uiSettings =
                        _uiSettings.copyWith(isScrollGesturesEnabled: value);
                    _controller?.setUiSettings(_uiSettings);
                  },
                ),
                BooleanSetting(
                  head: '旋转手势 [Android, iOS]',
                  selected: true,
                  onSelected: (value) {
                    _uiSettings =
                        _uiSettings.copyWith(isRotateGesturesEnabled: value);
                    _controller?.setUiSettings(_uiSettings);
                  },
                ),
                BooleanSetting(
                  head: '倾斜手势 [Android, iOS]',
                  selected: true,
                  onSelected: (value) {
                    _uiSettings =
                        _uiSettings.copyWith(isTiltGesturesEnabled: value);
                    _controller?.setUiSettings(_uiSettings);
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
