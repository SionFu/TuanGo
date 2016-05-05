//
//  TRBaseNavController.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRBaseNavController.h"
#import "DPAPI.h"
#import "TRMataDataTool.h"
#import "UIColor+FlatUI.h"

@interface TRBaseNavController ()
@end

@implementation TRBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.397 green:0.649 blue:1.000 alpha:1.000]];
     [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.929 green:0.420 blue:0.416 alpha:0.350]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    

    
      //设置navigationBar属性
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorFromHexCode:@"eb5352"]];

    
    //设置tabBar选中字体颜色  拿到颜色对象
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                         dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName,nil]
                                             forState:UIControlStateSelected];
    //修改tabBaritem的图片 维持原样,不要重新渲染
    self.tabBarItem.selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
