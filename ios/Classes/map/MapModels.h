//
// Created by Yohom Bao on 2018-12-15.
//

#import <Foundation/Foundation.h>
#import "MAPointAnnotation.h"
#import "MAPolyline.h"
#import "MAPolygon.h"

@class UnifiedMarkerOptions;
@class LatLng;
@class CameraPosition;
@class UnifiedPolylineOptions;
@class MAMapView;
@class UnifiedPolygonOptions;

@interface MarkerAnnotation : MAPointAnnotation
@property(nonatomic) UnifiedMarkerOptions *markerOptions;
@end

@interface PolygonOverlay : MAPolygon
@property(nonatomic) UnifiedPolygonOptions *polygonOptions;
@end

@interface PolylineOverlay : MAPolyline
@property(nonatomic) UnifiedPolylineOptions *options;
@end

@interface UnifiedAMapOptions : NSObject
/// “高德地图”Logo的位置
@property(nonatomic) NSInteger logoPosition;
@property(nonatomic) BOOL zOrderOnTop;

/// 地图模式
@property(nonatomic) NSInteger mapType;

/// 地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。
@property(nonatomic) CameraPosition *camera;

/// 比例尺功能是否可用
@property(nonatomic) BOOL scaleControlsEnabled;

/// 地图是否允许缩放
@property(nonatomic) BOOL zoomControlsEnabled;

/// 指南针是否可用。
@property(nonatomic) BOOL compassEnabled;

/// 拖动手势是否可用
@property(nonatomic) BOOL scrollGesturesEnabled;

/// 缩放手势是否可用
@property(nonatomic) BOOL zoomGesturesEnabled;

/// 地图倾斜手势（显示3D效果）是否可用
@property(nonatomic) BOOL tiltGesturesEnabled;

/// 地图旋转手势是否可用
@property(nonatomic) BOOL rotateGesturesEnabled;

- (NSString *)description;

@end

@interface CameraPosition : NSObject
/// 目标位置的屏幕中心点经纬度坐标。默认北京
@property(nonatomic) LatLng *target;

/// 目标可视区域的缩放级别。
@property(nonatomic) CGFloat zoom;

/// 目标可视区域的倾斜度，以角度为单位。
@property(nonatomic) CGFloat tilt;

/// 可视区域指向的方向，以角度为单位，从正北向逆时针方向计算，从0 度到360 度。
@property(nonatomic) CGFloat bearing;

- (NSString *)description;
@end

@interface LatLng : NSObject

@property(nonatomic) CGFloat latitude;
@property(nonatomic) CGFloat longitude;

- (CLLocationCoordinate2D)toCLLocationCoordinate2D;

- (NSString *)description;

@end

@interface UnifiedMarkerOptions : NSObject
/// Marker覆盖物的图标
@property(nonatomic) NSString *icon;
/// Marker覆盖物锚点在水平范围的比例
@property(nonatomic) CGFloat anchorU;
/// Marker覆盖物锚点垂直范围的比例
@property(nonatomic) CGFloat anchorV;
/// Marker覆盖物是否可拖拽
@property(nonatomic) BOOL draggable;
/// Marker覆盖物的InfoWindow是否允许显示, 可以通过 MarkerOptions.infoWindowEnable(BOOLean) 进行设置
@property(nonatomic) BOOL infoWindowEnable;
/// Marker覆盖物的位置坐标
@property(nonatomic) LatLng *position;
/// Marker覆盖物的水平偏移距离
@property(nonatomic) NSInteger infoWindowOffsetX;
/// Marker覆盖物的垂直偏移距离
@property(nonatomic) NSInteger infoWindowOffsetY;
/// 设置 Marker覆盖物的 文字描述
@property(nonatomic) NSString *snippet;
/// Marker覆盖物 的标题
@property(nonatomic) NSString *title;
/// Marker覆盖物 zIndex
@property(nonatomic) CGFloat zIndex;
/// 是否固定在屏幕一点, 注意，拖动或者手动改变经纬度，都会导致设置失效 [暂未实现]
@property(nonatomic) BOOL lockedToScreen;
/// 固定屏幕点的坐标 [iOS暂未实现]
@property(nonatomic) NSString *lockedScreenPoint;
/// 自定制弹出框view, 用于替换默认弹出框. [暂未实现]
@property(nonatomic) NSString *customCalloutView;
/// 默认为YES,当为NO时view忽略触摸事件
@property(nonatomic) BOOL enabled;
/// 是否高亮
@property(nonatomic) BOOL highlighted;
/// 设置是否处于选中状态, 外部如果要选中请使用mapView的selectAnnotation方法
@property(nonatomic) BOOL selected;
/// 显示在默认弹出框左侧的view [暂未实现]
@property(nonatomic) NSString *leftCalloutAccessoryView;
/// 显示在默认弹出框右侧的view [暂未实现]
@property(nonatomic) NSString *rightCalloutAccessoryView;

- (NSString *)description;

@end

@interface UnifiedMyLocationStyle : NSObject
/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值
@property(nonatomic) NSString *radiusFillColor;
/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值
@property(nonatomic) NSString *strokeColor;
/// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度
@property(nonatomic) CGFloat strokeWidth;
/// 是否显示定位小蓝点
@property(nonatomic) BOOL showMyLocation;
/// 精度圈是否显示，默认YES
@property(nonatomic) BOOL showsAccuracyRing;
/// 是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
@property(nonatomic) BOOL showsHeadingIndicator;
/// 定位点背景色，不设置默认白色
@property(nonatomic) NSString *locationDotBgColor;
/// 定位点蓝色圆点颜色，不设置默认蓝色
@property(nonatomic) NSString *locationDotFillColor;
/// 内部蓝色圆点是否使用律动效果, 默认YES
@property(nonatomic) BOOL enablePulseAnnimation;
/// 定位图标, 与蓝色原点互斥
@property(nonatomic) NSString *image;

- (NSString *)description;

- (void)applyTo:(MAMapView *)mapView;

@end

@interface UnifiedPolylineOptions : NSObject

+ (instancetype)initWithJson:(NSString *)json;

/// 顶点
@property(nonatomic) NSArray<LatLng *> *latLngList;
/// 线段的宽度
@property(nonatomic) CGFloat width;
/// 线段的颜色
@property(nonatomic) NSString *color;
/// 线段的Z轴值
@property(nonatomic) CGFloat zIndex;
/// 线段的可见属性
@property(nonatomic) BOOL isVisible;
/// 线段是否画虚线，默认为false，画实线
@property(nonatomic) BOOL isDottedLine;
/// 线段是否为大地曲线，默认false，不画大地曲线
@property(nonatomic) BOOL isGeodesic;
/// 虚线形状
@property(nonatomic) NSInteger dottedLineType;
/// Polyline尾部形状
@property(nonatomic) NSInteger lineCapType;
/// Polyline连接处形状
@property(nonatomic) NSInteger lineJoinType;
/// 线段是否使用渐变色
@property(nonatomic) BOOL isUseGradient;
/// 线段是否使用纹理贴图
@property(nonatomic) BOOL isUseTexture;

@end

@interface UnifiedUiSettings : NSObject
/// 设置缩放按钮的位置
@property(nonatomic) NSInteger zoomPosition;
/// 指南针
@property(nonatomic) BOOL isCompassEnabled;
/// 比例尺控件
@property(nonatomic) BOOL isScaleControlsEnabled;
/// 地图Logo
@property(nonatomic) NSInteger logoPosition;
/// 缩放手势
@property(nonatomic) BOOL isZoomGesturesEnabled;
/// 滑动手势
@property(nonatomic) BOOL isScrollGesturesEnabled;
/// 旋转手势
@property(nonatomic) BOOL isRotateGesturesEnabled;
/// 倾斜手势
@property(nonatomic) BOOL isTiltGesturesEnabled;

- (void)applyTo:(MAMapView *)map;

@end

@interface UnifiedPolygonOptions : NSObject

+ (instancetype)initWithJson:(NSString *)json;

@property(nonatomic) NSArray<LatLng *> *points;
@property(nonatomic) CGFloat strokeWidth;
@property(nonatomic) NSString *strokeColor;
@property(nonatomic) NSString *fillColor;
@property(nonatomic) NSUInteger lineJoinType;
@property(nonatomic) NSUInteger lineCapType;
@property(nonatomic) CGFloat miterLimit;
@property(nonatomic) NSUInteger lineDashType;

@end
