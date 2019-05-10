//
// Created by Yohom Bao on 2018-12-15.
//

#import <Foundation/Foundation.h>
#import "IMethodHandler.h"

@interface SetCustomMapStyleID : NSObject <MapMethodHandler>
@end

@interface SetCustomMapStylePath : NSObject <MapMethodHandler>
@end

@interface SetMapCustomEnable : NSObject <MapMethodHandler>
@end

@interface ConvertCoordinate : NSObject <MapMethodHandler>
@end

@interface GetCenterPoint : NSObject <MapMethodHandler>
@end

@interface CalcDistance : NSObject <MapMethodHandler>
@end

@interface ClearMap : NSObject<MapMethodHandler>
@end

@interface OpenOfflineManager : NSObject<MapMethodHandler>
@end

@interface SetLanguage : NSObject<MapMethodHandler>
@end

@interface SetMapType : NSObject<MapMethodHandler>
@end

@interface SetMyLocationStyle : NSObject<MapMethodHandler>
@end

@interface SetUiSettings : NSObject<MapMethodHandler>
@end

@interface ShowIndoorMap : NSObject<MapMethodHandler>
@end

@interface AddMarker : NSObject<MapMethodHandler>
@end

@interface AddMarkers : NSObject<MapMethodHandler>
@end

@interface AddPolyline : NSObject<MapMethodHandler>
@end

@interface ClearMarker : NSObject<MapMethodHandler>
@end

@interface ChangeLatLng : NSObject <MapMethodHandler>
@end

@interface SetMapStatusLimits : NSObject<MapMethodHandler>
@end

@interface SetPosition : NSObject<MapMethodHandler>
@end

@interface SetZoomLevel : NSObject<MapMethodHandler>
@end

@interface ZoomToSpan : NSObject <MapMethodHandler>
@end

@interface ScreenShot : NSObject<MapMethodHandler>
@end

@interface AddPolygon : NSObject<MapMethodHandler>
@end
