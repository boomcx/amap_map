//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

//region 地图
@class MAMapView;
@class FlutterMethodCall;

@protocol MapMethodHandler <NSObject>
@required
- (NSObject <MapMethodHandler> *)initWith:(MAMapView *)mapView;
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;
@end
//endregion

//region 搜索
@protocol SearchMethodHandler <NSObject>
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;
@end
//endregion

//region 导航
@protocol NaviMethodHandler <NSObject>
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;
@end
//endregion

//region 定位
@protocol LocationMethodHandler <NSObject>
@required
- (void)onMethodCall:(FlutterMethodCall *)call :(FlutterResult)result;
@end
//endregion