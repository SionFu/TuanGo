//
//  TRMataDataTool.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRMataDataTool.h"
#import "TRDeal.h"
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

@end
