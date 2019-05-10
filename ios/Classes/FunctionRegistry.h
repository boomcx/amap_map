//
// Created by Yohom Bao on 2018-12-12.
//

#import <Foundation/Foundation.h>

@protocol MapMethodHandler;
@interface MapFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <MapMethodHandler> *> *)mapMethodHandler;
@end

@protocol SearchMethodHandler;
@interface SearchFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <SearchMethodHandler> *> *)searchMethodHandler;
@end

@protocol NaviMethodHandler;
@interface NaviFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <NaviMethodHandler> *> *)naviMethodHandler;
@end

@protocol LocationMethodHandler;
@interface LocationFunctionRegistry : NSObject
+ (NSDictionary<NSString *, NSObject <LocationMethodHandler> *> *)locationMethodHandler;
@end