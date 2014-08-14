//
//  HsLocationManager.m
//  hospitalcloud_sdzy
//
//  Created by 123 on 14-6-16.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HsLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation HsLocationManager

IMP_SINGLETON(HsLocationManager)

- (instancetype)init{
    self = [super init];
    if(self){
        self.locationManager = [[CLLocationManager alloc] init];
        // 设置定位精度，十米，百米，最好
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        self.locationManager.distanceFilter = 1000.0f;
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)start{
    // 开始时时定位
    [self.locationManager startUpdatingLocation];
}

- (void)start:(id<HsLocationManagerDelegate>)delegate{
    self.delegate = delegate;
    [self start];
}
- (void)stop{
     [self.locationManager stopUpdatingLocation];
}

#pragma mark delegate

// 错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    NSLog(@"error");
    if(self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didFailWithError:)]){
        [self.delegate performSelector:@selector(locationManager:didFailWithError:) withObject:self withObject:error];
    }
}
// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%d", [locations count]);
//    CLLocation *oldLocation = locations[0];
//    CLLocationCoordinate2D oldCoordinate = oldLocation.coordinate;
//    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    
    CLLocation *newLocation = locations[1];
    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    NSLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
    
//    // 计算两个坐标距离
//    float distance = [newLocation distanceFromLocation:oldLocation];
//    NSLog(@"%f",distance);
    
    [manager stopUpdatingLocation];
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       if(error  != nil){
                           if(self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didFailWithError:)]){
                               [self.delegate performSelector:@selector(locationManager:didFailWithError:) withObject:self withObject:error];
                           }
                       }else{
                           for (CLPlacemark *place in placemarks) {
                               NSMutableDictionary *locationInfo = [NSMutableDictionary dictionary];
                               [locationInfo setValue:place.name forKey:@"name"];// 位置名
                               [locationInfo setValue:[NSNumber numberWithFloat:newCoordinate.longitude] forKey:@"longitude"];// 经度
                               [locationInfo setValue:[NSNumber numberWithFloat:newCoordinate.latitude] forKey:@"latitude"];// 纬度
                               [locationInfo setValue:place.thoroughfare forKey:@"thoroughfare"];// 街道
                               [locationInfo setValue:place.subThoroughfare forKey:@"subThoroughfare"]; // 子街道
                               [locationInfo setValue:place.locality forKey:@"locality"];// 市
                               [locationInfo setValue:place.subLocality forKey:@"subLocality"]; // 区
                               [locationInfo setValue:place.country forKey:@"country"]; // 国家
                               if(self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didFinishedLocation:)]){
                                   [self.delegate performSelector:@selector(locationManager:didFinishedLocation:) withObject:self withObject:locationInfo];
                               }
                            }
                       }
                   }];

}



// 6.0 调用此函数
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", @"ok");
    [manager stopUpdatingLocation];
    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       if(error  != nil){
                           if(self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didFailWithError:)]){
                               [self.delegate performSelector:@selector(locationManager:didFailWithError:) withObject:self withObject:error];
                           }
                       }else{
                           for (CLPlacemark *place in placemarks) {
                               NSMutableDictionary *locationInfo = [NSMutableDictionary dictionary];
                               [locationInfo setValue:place.name forKey:@"name"];// 位置名
                               [locationInfo setValue:[NSNumber numberWithFloat:newCoordinate.longitude] forKey:@"longitude"];// 经度
                               [locationInfo setValue:[NSNumber numberWithFloat:newCoordinate.latitude] forKey:@"latitude"];// 纬度
                               [locationInfo setValue:place.thoroughfare forKey:@"thoroughfare"];// 街道
                               [locationInfo setValue:place.subThoroughfare forKey:@"subThoroughfare"]; // 子街道
                               [locationInfo setValue:place.locality forKey:@"locality"];// 市
                               [locationInfo setValue:place.subLocality forKey:@"subLocality"]; // 区
                               [locationInfo setValue:place.country forKey:@"country"]; // 国家
                               if(self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didFinishedLocation:)]){
                                   [self.delegate performSelector:@selector(locationManager:didFinishedLocation:) withObject:self withObject:locationInfo];
                               }
                           }
                       }
                   }];

}


@end
