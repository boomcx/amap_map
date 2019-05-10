//
// Created by Yohom Bao on 2018-12-15.
//

#import "MapHandlers.h"
#import <CoreLocation/CoreLocation.h>
#import "MAMapView.h"
#import "AMapFoundationKit.h"
#import "AMapViewFactory.h"
#import "MapModels.h"
#import "MJExtension.h"
#import "UnifiedAssets.h"


@implementation SetCustomMapStyleID {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    NSString *styleId = (NSString *) paramDic[@"styleId"];

    NSLog(@"方法map#setCustomMapStyleID iOS: styleId -> %@", styleId);

    [_mapView setCustomMapStyleID:styleId];
    result(success);
}

@end

@implementation SetCustomMapStylePath {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    NSString *path = (NSString *) paramDic[@"path"];

    NSLog(@"方法map#setCustomMapStylePath iOS: path -> %@", path);

    NSData *data = [NSData dataWithContentsOfFile:[UnifiedAssets getAssetPath:path]];
    [_mapView setCustomMapStyleWithWebData:data];
    result(success);
}

@end

@implementation SetMapCustomEnable {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    BOOL enabled = [paramDic[@"enabled"] boolValue];

    NSLog(@"方法map#setMapCustomEnable iOS: enabled -> %d", enabled);

    [_mapView setCustomMapStyleEnabled:enabled];

    result(success);
}

@end

@implementation ConvertCoordinate {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;
    CGFloat lat = [paramDic[@"lat"] floatValue];
    CGFloat lon = [paramDic[@"lon"] floatValue];
    int intType = [paramDic[@"type"] intValue];
    AMapCoordinateType type = [self convertTypeWithInt:intType];
    CLLocationCoordinate2D coordinate2D = AMapCoordinateConvert(CLLocationCoordinate2DMake(lat, lon), type);
    NSString *r = [NSString stringWithFormat:@"{\"latitude\":%f,\"longitude\":%f}", coordinate2D.latitude, coordinate2D.longitude];
    result(r);
}

- (AMapCoordinateType)convertTypeWithInt:(int)type {
    switch (type) {
        case 0:
            return AMapCoordinateTypeGPS;
        case 1:
            return AMapCoordinateTypeBaidu;
        case 2:
            return AMapCoordinateTypeMapBar;
        case 3:
            return AMapCoordinateTypeMapABC;
        case 4:
            return AMapCoordinateTypeSoSoMap;
        case 5:
            return AMapCoordinateTypeAliYun;
        case 6:
            return AMapCoordinateTypeGoogle;
        default:
            return AMapCoordinateTypeGPS;
    }
}

@end

@implementation CalcDistance{
    MAMapView *_mapView;
}

- (NSObject<MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *params = [call arguments];
    NSDictionary *p1 = [params valueForKey:@"p1"];
    NSDictionary *p2 = [params valueForKey:@"p2"];
    CLLocationDistance distance = MAMetersBetweenMapPoints([self getPointFromDict:p1],[self getPointFromDict:p2]);
    result(@(distance));
}

-(MAMapPoint) getPointFromDict:(NSDictionary *) dict {
    CGFloat lat = [[dict valueForKey:@"latitude"] floatValue];
    CGFloat lng = [[dict valueForKey:@"longitude"] floatValue];
    return MAMapPointForCoordinate(CLLocationCoordinate2DMake(lat,lng));
}

@end

@implementation GetCenterPoint{
     MAMapView *_mapView;
}

- (NSObject<MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    CLLocationCoordinate2D coor = _mapView.centerCoordinate;
    LatLng *latlng = [LatLng new];
    latlng.latitude = coor.latitude;
    latlng.longitude = coor.longitude;
    result([latlng mj_JSONString]);
}

@end

@implementation ClearMap {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotations:_mapView.annotations];

    result(success);
}

@end

@implementation OpenOfflineManager {

}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    UIViewController *ctl = [MAOfflineMapViewController sharedInstance];
    UINavigationController *naviCtl = [[UINavigationController alloc] initWithRootViewController:ctl];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    
    [[ctl navigationItem]setLeftBarButtonItem:item];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: naviCtl animated:YES completion:nil];
}

-(void)dismiss{
    UIViewController *ctl = [MAOfflineMapViewController sharedInstance];
    if([ctl navigationController]){
        [[ctl navigationController] dismissViewControllerAnimated:true completion:nil];
    }
}

@end

@implementation SetLanguage {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    // 由于iOS端是从0开始算的, 所以这里减去1
    NSString *language = (NSString *) paramDic[@"language"];

    NSLog(@"方法map#setLanguage ios端参数: language -> %@", language);

    [_mapView performSelector:NSSelectorFromString(@"setMapLanguage:") withObject:language];

    result(success);
}

@end

@implementation SetMapType {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    // 由于iOS端是从0开始算的, 所以这里减去1
    NSInteger mapType = [paramDic[@"mapType"] integerValue] - 1;

    NSLog(@"方法map#setMapType ios端参数: mapType -> %d", mapType);

    [_mapView setMapType:(MAMapType) mapType];

    result(success);
}

@end

@implementation SetMyLocationStyle {
    MAMapView *_mapView;
}

- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *styleJson = (NSString *) paramDic[@"myLocationStyle"];

    NSLog(@"方法setMyLocationStyle ios端参数: styleJson -> %@", styleJson);
    [[UnifiedMyLocationStyle mj_objectWithKeyValues:styleJson] applyTo:_mapView];

    result(success);
}

@end

@implementation SetUiSettings {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *uiSettingsJson = (NSString *) paramDic[@"uiSettings"];

    NSLog(@"方法setUiSettings ios端参数: uiSettingsJson -> %@", uiSettingsJson);
    [[UnifiedUiSettings mj_objectWithKeyValues:uiSettingsJson] applyTo:_mapView];

    result(success);

}

@end

@implementation ShowIndoorMap {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    BOOL enabled = (BOOL) paramDic[@"showIndoorMap"];

    NSLog(@"方法map#showIndoorMap android端参数: enabled -> %d", enabled);

    _mapView.showsIndoorMap = enabled;

    result(success);
}

@end

@implementation AddMarker {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *optionsJson = (NSString *) paramDic[@"markerOptions"];

    NSLog(@"方法marker#addMarker ios端参数: optionsJson -> %@", optionsJson);
    UnifiedMarkerOptions *markerOptions = [UnifiedMarkerOptions mj_objectWithKeyValues:optionsJson];

    MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
    annotation.coordinate = [markerOptions.position toCLLocationCoordinate2D];
    annotation.title = markerOptions.title;
    annotation.subtitle = markerOptions.snippet;
    annotation.markerOptions = markerOptions;

    [_mapView addAnnotation:annotation];

    result(success);
}

@end

@implementation AddMarkers {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *moveToCenter = (NSString *) paramDic[@"moveToCenter"];
    NSString *optionsListJson = (NSString *) paramDic[@"markerOptionsList"];
    BOOL clear = (BOOL) paramDic[@"clear"];

    NSLog(@"方法marker#addMarkers ios端参数: optionsListJson -> %@", optionsListJson);
    if (clear) [_mapView removeAnnotations:_mapView.annotations];

    NSArray *rawOptionsList = [NSJSONSerialization JSONObjectWithData:[optionsListJson dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:kNilOptions
                                                                error:nil];
    NSMutableArray<MarkerAnnotation *> *optionList = [NSMutableArray array];

    for (NSUInteger i = 0; i < rawOptionsList.count; ++i) {
        UnifiedMarkerOptions *options = [UnifiedMarkerOptions mj_objectWithKeyValues:rawOptionsList[i]];
        MarkerAnnotation *annotation = [[MarkerAnnotation alloc] init];
        annotation.coordinate = [options.position toCLLocationCoordinate2D];
        annotation.title = options.title;
        annotation.subtitle = options.snippet;
        annotation.markerOptions = options;

        [optionList addObject:annotation];
    }

    [_mapView addAnnotations:optionList];
    if (moveToCenter) {
        [_mapView showAnnotations:optionList animated:YES];
    }

    result(success);
}

@end

@implementation AddPolyline {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSString *optionsJson = (NSString *) call.arguments[@"options"];

    NSLog(@"map#addPolyline ios端参数: optionsJson -> %@", optionsJson);

    UnifiedPolylineOptions *options = [UnifiedPolylineOptions initWithJson:optionsJson];

    NSUInteger count = options.latLngList.count;

    CLLocationCoordinate2D commonPolylineCoords[count];
    for (NSUInteger i = 0; i < count; ++i) {
        commonPolylineCoords[i] = [options.latLngList[i] toCLLocationCoordinate2D];
    }

    PolylineOverlay *polyline = [PolylineOverlay polylineWithCoordinates:commonPolylineCoords count:options.latLngList.count];
    polyline.options = options;
    [_mapView addOverlay:polyline];

    result(success);
}

@end

@implementation ClearMarker {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    [_mapView removeAnnotations:_mapView.annotations];

    result(success);
}

@end

@implementation ChangeLatLng {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *targetJson = (NSString *) paramDic[@"target"];

    LatLng *target = [LatLng mj_objectWithKeyValues:targetJson];

    [_mapView setCenterCoordinate:[target toCLLocationCoordinate2D] animated:YES];

    result(success);
}

@end

@implementation SetMapStatusLimits {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *center = (NSString *) paramDic[@"center"];
    CGFloat deltaLat = [paramDic[@"deltaLat"] floatValue];
    CGFloat deltaLng = [paramDic[@"deltaLng"] floatValue];

    NSLog(@"方法map#setMapStatusLimits ios端参数: center -> %@, deltaLat -> %f, deltaLng -> %f", center, deltaLat, deltaLng);


    LatLng *centerPosition = [LatLng mj_objectWithKeyValues:center];

    [_mapView setLimitRegion:MACoordinateRegionMake(
            [centerPosition toCLLocationCoordinate2D],
            MACoordinateSpanMake(deltaLat, deltaLng))
    ];

    result(success);
}

@end

@implementation SetPosition {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *target = (NSString *) paramDic[@"target"];
    CGFloat zoom = [paramDic[@"zoom"] floatValue];
    CGFloat tilt = [paramDic[@"tilt"] floatValue];

    LatLng *position = [LatLng mj_objectWithKeyValues:target];

    [_mapView setCenterCoordinate:[position toCLLocationCoordinate2D] animated:true];
    _mapView.zoomLevel = zoom;
    _mapView.rotationDegree = tilt;

    result(success);
}

@end

@implementation SetZoomLevel {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    CGFloat zoomLevel = [paramDic[@"zoomLevel"] floatValue];

    _mapView.zoomLevel = zoomLevel;

    result(success);
}

@end

@implementation ZoomToSpan {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    NSDictionary *paramDic = call.arguments;

    NSString *boundJson = (NSString *) paramDic[@"bound"];
    NSInteger padding = [paramDic[@"padding"] integerValue] / 2;

    NSArray <LatLng *> *latLngArray = [LatLng mj_objectArrayWithKeyValuesArray:boundJson];

    NSUInteger count = latLngArray.count;

    CLLocationCoordinate2D commonPolylineCoords[count];
    for (NSUInteger i = 0; i < count; ++i) {
        commonPolylineCoords[i] = [latLngArray[i] toCLLocationCoordinate2D];
    }

    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:count];
    [_mapView showOverlays:@[polyline] edgePadding:UIEdgeInsetsMake(padding, padding, padding, padding) animated:YES];
}

@end

@implementation ScreenShot {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
    CGRect rect = [_mapView frame];
    [_mapView takeSnapshotInRect:rect withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        if (resultImage == nil) {
            FlutterError *err = [FlutterError errorWithCode:@"截图失败,渲染未完成" message:@"截图失败,渲染未完成" details:nil];
            result(err);
            return;
        }
        if (state != 1) {
            FlutterError *err = [FlutterError errorWithCode:@"截图失败,渲染未完成" message:@"截图失败,渲染未完成" details:nil];
            result(err);
            return;
        }
        NSData *data = UIImageJPEGRepresentation(resultImage, 100);
        FlutterStandardTypedData *r = [FlutterStandardTypedData typedDataWithBytes:data];
        result(r);
    }];
}
@end

@implementation AddPolygon {
    MAMapView *_mapView;
}
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result {
  NSDictionary *paramDic = call.arguments;

  NSString *optionsJson = (NSString *) paramDic[@"options"];

  NSLog(@"方法map#addPolygon iOS: optionsJson -> %@", optionsJson);

  UnifiedPolygonOptions *options = [UnifiedPolygonOptions initWithJson:optionsJson];

  NSUInteger length = options.points.count;
  CLLocationCoordinate2D points[length];
  for (NSUInteger i = 0; i < length; ++i) {
    points[i] = CLLocationCoordinate2DMake(options.points[i].latitude, options.points[i].longitude);
  }

  PolygonOverlay * overlay = [PolygonOverlay polygonWithCoordinates:points count:length];
  overlay.polygonOptions = options;
  [_mapView addOverlay:overlay];

  result(success);
}
@end
