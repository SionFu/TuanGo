//
//  TRBusinessViewController.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRBusinessViewController.h"
#import "TRBusinessHeadView.h"
#import "UIView+Extension.h"
@interface TRBusinessViewController ()

@end

@implementation TRBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建/添加头视图
    [self setUpHeaderView];
}

#pragma mark --和界面相关
- (void)setUpHeaderView{
    //创建
    //直接添加nib视图 返回多个视图
    TRBusinessHeadView *headView = [[[NSBundle mainBundle]loadNibNamed:@"TRBusinessHeadView" owner:nil options:nil]firstObject];
    //设置frame   添加
    headView.frame = CGRectMake(0, 64, self.view.frame.size.width, 50);
    [self.view addSubview:headView];
    //设置父类tableView的y值
    self.tableView.y = 40;
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
