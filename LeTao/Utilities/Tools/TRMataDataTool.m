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







@end
