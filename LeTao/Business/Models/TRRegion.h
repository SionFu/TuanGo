//
//  TRRegion.h
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRRegion : NSObject
/**
 * 主区域的名字
 */
@property (nonatomic,strong) NSString *name;
/**
 * 主区域对应子区域的名字数组
 */
@property (nonatomic,strong) NSArray *subregions;
@end
