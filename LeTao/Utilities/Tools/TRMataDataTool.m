//
//  TRMataDataTool.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRMataDataTool.h"
#import "TRDeal.h"
#import "TRSort.h"
#import "TRCity.h"
#import "TRRegion.h"
#import "TRCategory.h"
#import "TRMenuData.h"
@implementation TRMataDataTool
+(NSArray *)parseDealsResult:(id)result{
    //1.获取deals对应的数组(NSDictionary..)
    NSArray *dealsArray = result[@"deals"];
    //2.循环NSDictionary==>TRDeal
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *dic in dealsArray) {
        TRDeal *deal = [[TRDeal alloc]init];
        [deal setValuesForKeysWithDictionary:dic];
         [muArray addObject:deal];
    }
    //3.返回数组
    return [muArray copy];
}

static NSArray *sortArry = nil;
+(NSArray *)getAllSorts{
    if (!sortArry) {
         //给定plist的名字和模型返回数组
        sortArry = [[self alloc]getAndPressWithplist:@"sorts.plist" withClass:[TRSort class]];
    }
    return sortArry;
}

static NSArray *cityArray = nil;
+(NSArray *)getAllCity{
    if (!cityArray) {
        cityArray = [[self alloc]getAndPressWithplist:@"cities.plist" withClass:[TRCity class]];
    }return cityArray;
}

static NSArray *categoryArray = nil;
+(NSArray *)getAllCategory{
    if (!categoryArray) {
        categoryArray = [[self alloc]getAndPressWithplist:@"categories.plist" withClass:[TRCategory class]];
    }return categoryArray;
}

+(NSArray *)getAllBusiness:(TRDeal *)deal{
    return [TRMataDataTool getModelArrayWithClass:[TRBusiness class] withArray:deal.businesses];
}

static NSArray *menuData = nil;
+(NSArray *)getAllMenuData{
    if (!menuData) {
        menuData = [[self alloc]getAndPressWithplist:@"menuData.plist" withClass:[TRMenuData class]];
    }return menuData;
}

+(NSArray *)getAllRegionsCityName:(NSString *)cityName{
    NSArray *alltictyArray = [self getAllCity];
    TRCity *findCity = [TRCity new];
    //获取所有城市的数据
    for (TRCity *city in alltictyArray) {
      //从所以数据的城市中,寻找city name 对应的模型对象
        if([city.name isEqualToString:cityName]){
          //循环把区域数组 转成TRRegion ,返回
            findCity = city;
            break;
        }
        
    }
    return  [TRMataDataTool getModelArrayWithClass:[TRRegion class]withArray:findCity.regions];
   
}

+ (NSArray *)getModelArrayWithClass:(Class)modeClass withArray:(NSArray *)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic  in array) {
        id instance = [modeClass new];
        [instance setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:instance];
    }return [mutableArray copy];
}

- (NSArray *)getAndPressWithplist:(NSString *)fileName withClass:(Class)modeClass{
    
        //拼接路径
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
        //读取plist数组
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    
   return  [TRMataDataTool getModelArrayWithClass:modeClass withArray:array];
        //循环转换 成modeClass
//    NSMutableArray *mutableArray = [NSMutableArray array];
//    for (NSDictionary *dic in array) {
//        //返回的是实例对象
//        id instance = [modeClass new];
//        //KVC 绑定
//        [instance setValuesForKeysWithDictionary:dic];
//        //添加
//        [mutableArray addObject:instance];
//    }
//    return [mutableArray copy];
}
static NSString *_cityName = nil;
+ (void)setSelectedCityName:(NSString *)cityName{
    _cityName = cityName;
}
+ (NSString *)getSelectedCityName{
    return _cityName;
}

+ (TRCategory *)getCategoryWIthDeal:(TRDeal *)deal{
    //获取该订单的所属分类 "简餐快餐" "小吃" "小吃快餐" "东北菜"
    NSArray *categoryArrayFromServer = deal.categories;
    //获取所有分类的数组
    NSArray *categoryArrayFromPlist = [self getAllCategory];
    for (NSString *categoryStr in categoryArrayFromServer) {
        for (TRCategory *category in categoryArrayFromPlist) {
            
            //看主分类的名字是否相等("美食"
            if ([categoryStr isEqualToString:category.name]) {
                return category;
            }
            //看子分类的名字是否相等("越南菜"
            if ([category.subcategories containsObject:categoryStr]) {
                return category;
            }
        }
    }
    //找不到所属分类
    return nil;
}



@end
