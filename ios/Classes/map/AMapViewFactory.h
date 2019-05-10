//
// Created by Yohom Bao on 2018/11/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "MAMapKit.h"

static NSString *success = @"调用成功";

@class UnifiedAMapOptions;

@interface AMapViewFactory : NSObject <FlutterPlatformViewFactory>
@end

@interface AMapView : NSObject <FlutterPlatformView, MAMapViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame
                      options:(UnifiedAMapOptions *)options
               viewIdentifier:(int64_t)viewId;

- (void) setup;
@end
