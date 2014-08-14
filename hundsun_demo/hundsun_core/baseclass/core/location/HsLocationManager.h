//
//  HsLocationManager.h
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-16.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HsLocationManagerDelegate;

@interface HsLocationManager : NSObject

HEAD_SINGLETON(HsLocationManager)

@property (nonatomic,weak) id<HsLocationManagerDelegate> delegate;

- (void)start;

- (void)start:(id<HsLocationManagerDelegate>)delegate;

- (void)stop;

@end


@protocol HsLocationManagerDelegate <NSObject>

- (void)locationManager:(HsLocationManager *)locationManager didFinishedLocation:(NSDictionary *)locationInfo;//成功

- (void)locationManager:(HsLocationManager *)locationManager didFailWithError:(NSError *)error;//失败

@end