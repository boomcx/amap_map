//
// Created by Yohom Bao on 2018-12-15.
//

#import "MAMapView.h"
#import "MapModels.h"
#import "NSString+Color.h"
#import "MJExtension.h"
#import "MAPolygon.h"


@implementation MarkerAnnotation {

}

@end

@implementation PolygonOverlay {

}
@end

@implementation PolylineOverlay {

}
@end

@implementation UnifiedAMapOptions {
}

- (NSString *)description {
  NSMutableString *description = [NSMutableString string];
  [description appendFormat:@"self.logoPosition=%i", self.logoPosition];
  [description appendFormat:@", self.zOrderOnTop=%d", self.zOrderOnTop];
  [description appendFormat:@", self.mapType=%i", self.mapType];
  [description appendFormat:@", self.camera=%@", self.camera];
  [description appendFormat:@", self.scaleControlsEnabled=%d", self.scaleControlsEnabled];
  [description appendFormat:@", self.zoomControlsEnabled=%d", self.zoomControlsEnabled];
  [description appendFormat:@", self.compassEnabled=%d", self.compassEnabled];
  [description appendFormat:@", self.scrollGesturesEnabled=%d", self.scrollGesturesEnabled];
  [description appendFormat:@", self.zoomGesturesEnabled=%d", self.zoomGesturesEnabled];
  [description appendFormat:@", self.tiltGesturesEnabled=%d", self.tiltGesturesEnabled];
  [description appendFormat:@", self.rotateGesturesEnabled=%d", self.rotateGesturesEnabled];

  NSMutableString *superDescription = [[super description] mutableCopy];
  NSUInteger length = [superDescription length];

  if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
    [superDescription insertString:@", " atIndex:length - 1];
    [superDescription insertString:description atIndex:length + 1];
    return superDescription;
  } else {
    return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
  }
}

@end

@implementation CameraPosition {
}

- (NSString *)description {
  NSMutableString *description = [NSMutableString string];
  [description appendFormat:@"self.target=%@", self.target];
  [description appendFormat:@", self.zoom=%f", self.zoom];
  [description appendFormat:@", self.tilt=%f", self.tilt];
  [description appendFormat:@", self.bearing=%f", self.bearing];

  NSMutableString *superDescription = [[super description] mutableCopy];
  NSUInteger length = [superDescription length];

  if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
    [superDescription insertString:@", " atIndex:length - 1];
    [superDescription insertString:description atIndex:length + 1];
    return superDescription;
  } else {
    return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
  }
}

@end

@implementation LatLng {
}

- (CLLocationCoordinate2D)toCLLocationCoordinate2D {
  return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (NSString *)description {
  NSMutableString *description = [NSMutableString string];
  [description appendFormat:@"self.latitude=%f", self.latitude];
  [description appendFormat:@", self.longitude=%f", self.longitude];

  NSMutableString *superDescription = [[super description] mutableCopy];
  NSUInteger length = [superDescription length];

  if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
    [superDescription insertString:@", " atIndex:length - 1];
    [superDescription insertString:description atIndex:length + 1];
    return superDescription;
  } else {
    return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
  }
}

@end

@implementation UnifiedMarkerOptions {

}
- (NSString *)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.icon=%p", self.icon];
  [description appendFormat:@", self.anchorU=%f", self.anchorU];
  [description appendFormat:@", self.anchorV=%f", self.anchorV];
  [description appendFormat:@", self.draggable=%d", self.draggable];
  [description appendFormat:@", self.infoWindowEnable=%d", self.infoWindowEnable];
  [description appendFormat:@", self.position=%@", self.position];
  [description appendFormat:@", self.infoWindowOffsetX=%i", self.infoWindowOffsetX];
  [description appendFormat:@", self.infoWindowOffsetY=%i", self.infoWindowOffsetY];
  [description appendFormat:@", self.snippet=%p", self.snippet];
  [description appendFormat:@", self.title=%p", self.title];
  [description appendFormat:@", self.zIndex=%f", self.zIndex];
  [description appendFormat:@", self.lockedToScreen=%d", self.lockedToScreen];
  [description appendFormat:@", self.lockedScreenPoint=%@", self.lockedScreenPoint];
  [description appendFormat:@", self.customCalloutView=%@", self.customCalloutView];
  [description appendFormat:@", self.enabled=%d", self.enabled];
  [description appendFormat:@", self.highlighted=%d", self.highlighted];
  [description appendFormat:@", self.selected=%d", self.selected];
  [description appendFormat:@", self.leftCalloutAccessoryView=%@", self.leftCalloutAccessoryView];
  [description appendFormat:@", self.rightCalloutAccessoryView=%@", self.rightCalloutAccessoryView];
  [description appendString:@">"];
  return description;
}

@end

@implementation UnifiedMyLocationStyle {

}

- (NSString *)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.radiusFillColor=%p", self.radiusFillColor];
  [description appendFormat:@", self.strokeColor=%p", self.strokeColor];
  [description appendFormat:@", self.strokeWidth=%f", self.strokeWidth];
  [description appendFormat:@", self.showsAccuracyRing=%d", self.showsAccuracyRing];
  [description appendFormat:@", self.showsHeadingIndicator=%d", self.showsHeadingIndicator];
  [description appendFormat:@", self.locationDotBgColor=%p", self.locationDotBgColor];
  [description appendFormat:@", self.locationDotFillColor=%p", self.locationDotFillColor];
  [description appendFormat:@", self.enablePulseAnnimation=%d", self.enablePulseAnnimation];
  [description appendFormat:@", self.image=%p", self.image];
  [description appendString:@">"];
  return description;
}

- (void)applyTo:(MAMapView *)mapView {
  MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];

  r.showsAccuracyRing = _showsAccuracyRing;
  r.showsHeadingIndicator = _showsHeadingIndicator;
  r.fillColor = [_radiusFillColor hexStringToColor];
  r.strokeColor = [_strokeColor hexStringToColor];
  r.lineWidth = _strokeWidth;
  r.enablePulseAnnimation = _enablePulseAnnimation;
  r.locationDotBgColor = [_locationDotBgColor hexStringToColor];
  r.locationDotFillColor = [_locationDotFillColor hexStringToColor];
//    r.image = nil;

  mapView.showsUserLocation = _showMyLocation;

  // 如果要跟踪方向, 那么就设置为userTrackingMode
  if (_showsHeadingIndicator) {
    mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
  } else if (_showMyLocation) {
    mapView.userTrackingMode = MAUserTrackingModeFollow;
  }
  [mapView updateUserLocationRepresentation:r];
}


@end

@implementation UnifiedPolylineOptions {

}
+ (instancetype)initWithJson:(NSString *)json {
  [UnifiedPolylineOptions mj_setupObjectClassInArray:^NSDictionary * {
    return @{
        @"latLngList": @"LatLng",
    };
  }];
  return [UnifiedPolylineOptions mj_objectWithKeyValues:json];
}

@end

@implementation UnifiedUiSettings

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
  return YES;
}

- (void)applyTo:(MAMapView *)map {
  // todo 设置logo的位置
  map.showsCompass = self.isCompassEnabled;
  map.showsScale = self.isScaleControlsEnabled;
  map.zoomEnabled = self.isZoomGesturesEnabled;
  map.rotateEnabled = self.isRotateGesturesEnabled;
  map.scrollEnabled = self.isScrollGesturesEnabled;
  map.rotateCameraEnabled = self.isTiltGesturesEnabled;
}

@end

@implementation UnifiedPolygonOptions

+ (instancetype)initWithJson:(NSString *)json {
  [UnifiedPolygonOptions mj_setupObjectClassInArray:^NSDictionary * {
    return @{
        @"points": @"LatLng",
    };
  }];
  return [UnifiedPolygonOptions mj_objectWithKeyValues:json];
}

@end