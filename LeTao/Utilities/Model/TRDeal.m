//
//  TRDeal.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRDeal.h"

@implementation TRDeal
-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    //key :字典的对应key ;value :字典 key对应的value
    if ([key isEqualToString:@"description"]) {
        //value赋值给属性
        self.desc = value;
    }
}
@end
