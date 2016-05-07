//
//  TRMataDataTool.h
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRDeal.h"
#import "TRBusiness.h"
#import "TRDeal.h"
#import "TRCategory.h"
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
 *  给定城市的名字(set:赋值)
 */
+ (void)setSelectedCityName:(NSString *)cityName;

/**
 * 返回城市的名字get获取
 */
+ (NSString *)getSelectedCityName;

/**
 * 给定某个订单对象,返回 所有是商所有商家数组 (TRBusiness)
 */
+ (NSArray *)getAllBusiness: (TRDeal *)deal;
/**
 *  给定订单返回所属了分类
 */
+ (TRCategory *)getCategoryWIthDeal:(TRDeal *)deal;

/**
 * 返回菜单的内容
 */
+ (NSArray *)getAllMenuData;
@end
