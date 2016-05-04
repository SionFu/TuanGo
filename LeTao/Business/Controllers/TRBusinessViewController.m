//
//  TRBusinessViewController.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRBusinessViewController.h"

@interface TRBusinessViewController ()

@end

@implementation TRBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark -- 设置商家的请求的参数
- (void)settingRequestparams:(NSMutableDictionary *)params{
    //设置界面上的分类 区域 排序 城市
#warning TOOO:设置四个参数
    params[@"city"]     = @"北京";
    params[@"category"] = @"美食";
    params[@"region"]   = @"朝阳区";
    params[@"sort"]     = @2;
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
