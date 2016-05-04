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
        sortArry = [[self alloc]getAndPressWithOlist:@"sorts.plist" withClass:[TRSort class]];
    }
    return sortArry;
}

- (NSArray *)getAndPressWithOlist:(NSString *)fileName withClass:(Class)modeClass{
    
        //拼接路径
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
        //读取plist数组
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
        //循环转换 成modeClass
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        //返回的是实例对象
        id instance = [TRDeal new];
        //KVC 绑定
        [instance setValuesForKeysWithDictionary:dic];
        //添加
        [mutableArray addObject:instance];
    }
    return [mutableArray copy];
}









@end
