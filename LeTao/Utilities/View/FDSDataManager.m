//
//  FDSDataManager.m
//  iWeater
//
//  Created by tarena on 16/4/25.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "FDSDataManager.h"
#import "FDSCity.h"

@implementation FDSDataManager
static FDSDataManager *_dataManager = nil;
+ (FDSDataManager *)sharedDataManger {
    if (!_dataManager) {
        _dataManager = [FDSDataManager new];
    }
    return _dataManager;
}
static NSArray *_cityGroupArray = nil;
+ (NSArray *)getAllCityGroups {
    if (!_cityGroupArray) {
        _cityGroupArray = [[self alloc] getCityGroups];
    }
    return _cityGroupArray;
}
- (NSArray *)getCityGroups {
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
    NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:plistPath];
    //所有字典对象转成模型对象
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in cityGroupArray) {
        //声明一个空的FDSCityGroup对象
        FDSCity *cityGroup = [FDSCity new];
        //KVC绑定模型对象属性和字典key的关系
        [cityGroup setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:cityGroup];
    }
    
    return [mutableArray copy];
}










@end
