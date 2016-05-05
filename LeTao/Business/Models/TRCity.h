//
//  TRCity.h
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCity : NSObject
/**
 *  城市名称
 */
@property (nonatomic,strong) NSString *name;
/**
 * 拼音
 */
@property (nonatomic,strong) NSString *pinYin;
/**
 * 拼音头
 */
@property (nonatomic,strong) NSString *pinYinHead;
/**
 * 地区
 */
@property (nonatomic,strong) NSArray *regions;
@end
