//
//  TRLocationManager.h
//  Demo01_LocationManager
//
//  Created by tarena on 16/4/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLocationManager : NSObject

//给定block；目的获取用户的位置
+ (void)getUserLocation:(void(^)(double latitude, double longitude))locationBlock;



//给定block 目的获取用户所在城市的名
+ (void)getUserCityName:(void(^)(NSString * cityName))cityBlock;



@end
