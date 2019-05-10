#import "AMapBaseMapPlugin.h"
#import "AMapViewFactory.h"
#import "IMethodHandler.h"
#import "FunctionRegistry.h"

static NSObject <FlutterPluginRegistrar> *_registrar;

@implementation AMapBaseMapPlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [AMapServices sharedServices].enableHTTPS = YES;
    _registrar = registrar;

    // 设置权限 channel
    FlutterMethodChannel *permissionChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/permission"
                  binaryMessenger:[registrar messenger]];
    [permissionChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        result(@YES);
    }];

    // 设置key channel
    FlutterMethodChannel *setKeyChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/amap_base"
                  binaryMessenger:[registrar messenger]];
    [setKeyChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([@"setKey" isEqualToString:call.method]) {
            NSString *key = call.arguments[@"key"];
            [AMapServices sharedServices].apiKey = key;
            result(@"key设置成功");
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    // 工具channel
    FlutterMethodChannel *toolChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/tool"
                  binaryMessenger:[registrar messenger]];
    [toolChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    // 搜索channel
    FlutterMethodChannel *searchChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/search"
                  binaryMessenger:[registrar messenger]];
    [searchChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <SearchMethodHandler> *handler = [SearchFunctionRegistry searchMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    // 离线地图 channel
    FlutterMethodChannel *offlineChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/offline"
                  binaryMessenger:[registrar messenger]];
    [offlineChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <MapMethodHandler> *handler = [MapFunctionRegistry mapMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    // 导航 channel
    FlutterMethodChannel *naviChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/navi"
                  binaryMessenger:[registrar messenger]];
    [naviChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <NaviMethodHandler> *handler = [NaviFunctionRegistry naviMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    // 定位 channel
    FlutterMethodChannel *locationChannel = [FlutterMethodChannel
            methodChannelWithName:@"me.yohom/location"
                  binaryMessenger:[registrar messenger]];
    [locationChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSObject <LocationMethodHandler> *handler = [LocationFunctionRegistry locationMethodHandler][call.method];
        if (handler) {
            [[handler init] onMethodCall:call :result];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    // MapView
    [_registrar registerViewFactory:[[AMapViewFactory alloc] init]
                             withId:@"me.yohom/AMapView"];

}

+ (NSObject <FlutterPluginRegistrar> *)registrar {
    return _registrar;
}

@end
