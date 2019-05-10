//
// Created by Yohom Bao on 2018/11/25.
//

#import "AMapViewFactory.h"
#import "MAMapView.h"
#import "MapModels.h"
#import "AMapBaseMapPlugin.h"
#import "UnifiedAssets.h"
#import "MJExtension.h"
#import "NSString+Color.h"
#import "FunctionRegistry.h"
#import "MapHandlers.h"

static NSString *mapChannelName = @"me.yohom/map";
static NSString *markerClickedChannelName = @"me.yohom/marker_clicked";
static NSString *mapDragChangeChannelName = @"me.yohom/map_drag_change";

@interface MarkerEventHandler : NSObject <FlutterStreamHandler>
@property(nonatomic) FlutterEventSink sink;
@end

@implementation MarkerEventHandler {
}

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
  _sink = events;
  return nil;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
  return nil;
}
@end


@interface MapEventHandler : NSObject <FlutterStreamHandler>
@property(nonatomic) FlutterEventSink sink;
@end

@implementation MapEventHandler {
}

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    _sink = events;
    return nil;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}
@end

@implementation AMapViewFactory {
}

- (NSObject <FlutterMessageCodec> *)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                     viewIdentifier:(int64_t)viewId
                                          arguments:(id _Nullable)args {
  UnifiedAMapOptions *options = [UnifiedAMapOptions mj_objectWithKeyValues:(NSString *) args];

  AMapView *view = [[AMapView alloc] initWithFrame:frame
                                           options:options
                                    viewIdentifier:viewId];
  return view;
}

@end

@implementation AMapView {
  CGRect _frame;
  int64_t _viewId;
  UnifiedAMapOptions *_options;
  FlutterMethodChannel *_methodChannel;
  FlutterEventChannel *_markerClickedEventChannel;
  FlutterEventChannel *_mapDragChangeEventChannel;
  MAMapView *_mapView;
  MarkerEventHandler *_eventHandler;
  MapEventHandler *_mapHandler;
}

- (instancetype)initWithFrame:(CGRect)frame
                      options:(UnifiedAMapOptions *)options
               viewIdentifier:(int64_t)viewId {
  self = [super init];
  if (self) {
    _frame = frame;
    _viewId = viewId;
    _options = options;

    _mapView = [[MAMapView alloc] initWithFrame:_frame];
    [self setup];
  }
  return self;
}

- (UIView *)view {
  return _mapView;
}

- (void)setup {
  //region 初始化地图配置
  // 尽可能地统一android端的api了, ios这边的配置选项多很多, 后期再观察吧
  // 因为android端的mapType从1开始, 所以这里减去1
  _mapView.mapType = (MAMapType) (_options.mapType - 1);
  _mapView.showsScale = _options.scaleControlsEnabled;
  _mapView.zoomEnabled = _options.zoomGesturesEnabled;
  _mapView.showsCompass = _options.compassEnabled;
  _mapView.scrollEnabled = _options.scrollGesturesEnabled;
  _mapView.cameraDegree = _options.camera.tilt;
  _mapView.rotateEnabled = _options.rotateGesturesEnabled;
  if (_options.camera.target) {
    _mapView.centerCoordinate = [_options.camera.target toCLLocationCoordinate2D];
  }
  _mapView.zoomLevel = _options.camera.zoom;
  // fixme: logo位置设置无效
  CGPoint logoPosition = CGPointMake(0, _mapView.bounds.size.height);
  if (_options.logoPosition == 0) { // 左下角
    logoPosition = CGPointMake(0, _mapView.bounds.size.height);
  } else if (_options.logoPosition == 1) { // 底部中央
    logoPosition = CGPointMake(_mapView.bounds.size.width / 2, _mapView.bounds.size.height);
  } else if (_options.logoPosition == 2) { // 底部右侧
    logoPosition = CGPointMake(_mapView.bounds.size.width, _mapView.bounds.size.height);
  }
  _mapView.logoCenter = logoPosition;
  _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  //endregion

  _methodChannel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"%@%lld", mapChannelName, _viewId]
                                               binaryMessenger:[AMapBaseMapPlugin registrar].messenger];
  __weak __typeof__(self) weakSelf = self;
  [_methodChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
    NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
    if (handler) {
      __typeof__(self) strongSelf = weakSelf;
      [[handler initWith:strongSelf->_mapView] onMethodCall:call :result];
    } else {
      result(FlutterMethodNotImplemented);
    }
  }];
  _mapView.delegate = weakSelf;

  _eventHandler = [[MarkerEventHandler alloc] init];
  _markerClickedEventChannel = [FlutterEventChannel eventChannelWithName:[NSString stringWithFormat:@"%@%lld", markerClickedChannelName, _viewId]
                                                         binaryMessenger:[AMapBaseMapPlugin registrar].messenger];
  [_markerClickedEventChannel setStreamHandler:_eventHandler];

   _mapHandler = [[MapEventHandler alloc] init];
   _mapDragChangeEventChannel = [FlutterEventChannel eventChannelWithName:[NSString stringWithFormat:@"%@", mapDragChangeChannelName]
                                                           binaryMessenger:[AMapBaseMapPlugin registrar].messenger];
   [_mapDragChangeEventChannel setStreamHandler:_mapHandler];

}

#pragma MAMapViewDelegate

/// 拖拽
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    LatLng *coor = [[LatLng alloc] init];
    coor.longitude =mapView.centerCoordinate.longitude;
    coor.latitude =mapView.centerCoordinate.latitude;
//    NSLog(@"%@", [coor mj_JSONString]);
    !_mapHandler.sink?:_mapHandler.sink([coor mj_JSONString]);
}

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
//    !_mapHandler.sink?:_mapHandler.sink(nil);
}

- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
    [locationManager requestAlwaysAuthorization];
}

/// 点击annotation回调
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
  if ([view.annotation isKindOfClass:[MarkerAnnotation class]]) {
    MarkerAnnotation *annotation = (MarkerAnnotation *) view.annotation;
    _eventHandler.sink([annotation.markerOptions mj_JSONString]);
  }
}

/// 渲染overlay回调
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
  // 绘制折线
  if ([overlay isKindOfClass:[PolylineOverlay class]]) {
    PolylineOverlay *polyline = (PolylineOverlay *) overlay;

    MAPolylineRenderer *renderer = [[MAPolylineRenderer alloc] initWithPolyline:polyline];

    UnifiedPolylineOptions *options = [polyline options];

    renderer.lineWidth = (CGFloat) (options.width * 0.5); // 相同的值, Android的线比iOS的粗
    renderer.strokeColor = [options.color hexStringToColor];
    renderer.lineJoinType = (MALineJoinType) options.lineJoinType;
    renderer.lineCapType = (MALineCapType) options.lineCapType;
    if (options.isDottedLine) {
      renderer.lineDashType = (MALineDashType) ((MALineCapType) options.dottedLineType + 1);
    } else {
      renderer.lineDashType = kMALineDashTypeNone;
    }

    return renderer;
  }

  if ([overlay isKindOfClass:[PolygonOverlay class]]) {
    PolygonOverlay *polygon = (PolygonOverlay *) overlay;

    MAPolygonRenderer *renderer = [[MAPolygonRenderer alloc] initWithPolygon:polygon];

    UnifiedPolygonOptions *options = polygon.polygonOptions;

    renderer.lineWidth = options.strokeWidth;
    renderer.strokeColor = [options.strokeColor hexStringToColor];
    renderer.fillColor = [options.fillColor hexStringToColor];
    renderer.lineJoinType = (MALineJoinType) options.lineJoinType;
    renderer.lineCapType = (MALineCapType) options.lineCapType;
    renderer.miterLimit = options.miterLimit;
    renderer.lineDashType = (MALineDashType) options.lineDashType;
    return renderer;
  }

  return nil;
}

/// 渲染annotation, 就是Android中的marker
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
  if ([annotation isKindOfClass:[MAUserLocation class]]) {
    return nil;
  }

  if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
    static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";

    MAAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
    if (annotationView == nil) {
      annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                    reuseIdentifier:routePlanningCellIdentifier];
    }

    if ([annotation isKindOfClass:[MarkerAnnotation class]]) {
      UnifiedMarkerOptions *options = ((MarkerAnnotation *) annotation).markerOptions;
      annotationView.zIndex = (NSInteger) options.zIndex;
      if (options.icon != nil) {
        annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getAssetPath:options.icon]];
      } else {
        annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/default_marker.png"]];
      }
      annotationView.centerOffset = CGPointMake(options.anchorU, options.anchorV);
      annotationView.calloutOffset = CGPointMake(options.infoWindowOffsetX, options.infoWindowOffsetY);
      annotationView.draggable = options.draggable;
      annotationView.canShowCallout = options.infoWindowEnable;
      annotationView.enabled = options.enabled;
      annotationView.highlighted = options.highlighted;
      annotationView.selected = options.selected;
    } else {
      if ([[annotation title] isEqualToString:@"起点"]) {
        annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/amap_start.png"]];
      } else if ([[annotation title] isEqualToString:@"终点"]) {
        annotationView.image = [UIImage imageWithContentsOfFile:[UnifiedAssets getDefaultAssetPath:@"images/amap_end.png"]];
      }
    }

    if (annotationView.image != nil) {
      CGSize size = annotationView.imageView.frame.size;
      annotationView.frame = CGRectMake(annotationView.center.x + size.width / 2, annotationView.center.y, 36, 36);
      annotationView.centerOffset = CGPointMake(0, -18);
    }

    return annotationView;
  }

  return nil;
}

@end
