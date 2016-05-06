//
//  TRLocationManager.m
//  Demo01_LocationManager
//
//  Created by tarena on 16/4/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface TRLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
//block属性(记录用户的位置)
@property (nonatomic, copy) void(^saveLocation)(double latitude, double longitude);

//block 反地理编码相关属性
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLGeocoder *usercoder;
@end

@implementation TRLocationManager



+ (instancetype)sharedLocationManager {
    static TRLocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[TRLocationManager alloc] init];
    }
    return locationManager;
}
- (instancetype)init {
    if (self = [super init]) {
        //初始化manager
        self.manager = [CLLocationManager new];
        //征求用户同意(假定用户同意定位; iOS8.0+); Info.plist添加key
        [self.manager requestWhenInUseAuthorization];
        //设置代理
        self.manager.delegate = self;
    }
    return self;
}

+ (void)getUserLocation:(void (^)(double, double))locationBlock {
    //获取TRLocationManager单例
    TRLocationManager *locationManager = [TRLocationManager sharedLocationManager];
    [locationManager getUserLocation:locationBlock];
} 
- (void)getUserLocation:(void (^)(double, double))locationBlock {
    //判定定位是否可用(用户是否同意)
    if (![CLLocationManager locationServicesEnabled]) {
        //定位服务没有开启，直接返回
        return;
    }
    
    //判定当前manager对象是否为空
    if (!self.manager) {
        //重新初始化，重新设置代理
        self.manager = [CLLocationManager new];
        self.manager.delegate = self;
    }
    
    //把locationBlock赋值给saveLocation属性
    self.saveLocation = locationBlock;
    
    //设置位置更新阈值
    self.manager.distanceFilter = 1000;
    //设置定位精确度
    self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //定位服务开启
    [self.manager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    //获取用户的位置
    CLLocation *userLocation = [locations lastObject];
    //调用saveLocationblock
    self.saveLocation(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    //防止多次定位(需求：只想获取用户位置一次)
    self.manager = nil;
    
}

+ (void)getUserCityName:(void (^)(NSString *))cityBlock {
    TRLocationManager *sharedMgr = [TRLocationManager sharedLocationManager];
    [sharedMgr getUserCityName:cityBlock];
}
- (void)getUserCityName:(void (^)(NSString *))cityBlock {
    [TRLocationManager getUserLocation:^(double latitude, double longitude) {
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //前提：假定iOS系统的语言是中文
            if (!error) {
                CLPlacemark *placemark = [placemarks lastObject];
                //获取城市名字
                NSString *cityName = placemark.addressDictionary[@"City"];
                //在城市后面去掉市
                cityName = [cityName substringToIndex:cityName.length-1];
                //执行block
                cityBlock(cityName);
            }
        }];
    }];
    
}









@end
