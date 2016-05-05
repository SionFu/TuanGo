//
//  TRMataDataTool.h
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRMataDataTool : NSObject
/**
 *  给定服务器返回result数据(字典),返回所有订单模型对象数组成的数组(TRDeal)
 */
+(NSArray *)parseDealsResult:(id)result;


/**
 * 返回所有的排序数组TRSort
 */
+ (NSArray*)getAllSorts;
/**
 *  返回所有城市的数组(TRCity)
 */
+ (NSArray *)getAllCity;
/**
 * 返回所有城市的全部分类(TRCategory)
 */
+ (NSArray *)getAllCategory;
/**
 *  给定城市名字,返回对应该城市的所有区域的数组
 */
+(NSArray *)getAllRegionsCityName:(NSString *)cityName;

/**
 *  
 */
@end
