//
//  FDSCity.h
//  iWeater
//
//  Created by tarena on 16/4/25.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDSCity : NSObject
//模型类中的属性名称要和字典的key一模一样
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSString *title;

@end
