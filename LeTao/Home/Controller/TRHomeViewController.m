//
//  TRHomeViewController.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRHomeViewController.h"
#import "TRLocationManager.h"
#import "TRMataDataTool.h"
@interface TRHomeViewController ()

@end

@implementation TRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserCityName];
}
- (void)getUserCityName{
    [TRLocationManager getUserCityName:^(NSString *cityName) {
       //使用工具类存储位置信息
        [TRMataDataTool setSelectedCityName:cityName];
    }];
}
#pragma mark -- 设置请求参数
- (void)settingRequestparams:(NSMutableDictionary *)params{
    //设置category(界面选择按钮)+city(用户的位置)
#warning TOOO:设置城市
    params[@"city"] = @"北京";
    params[@"category"] = @"美食";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
