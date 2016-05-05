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

@interface TRBaseNavController ()
@end

@implementation TRBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.397 green:0.649 blue:1.000 alpha:1.000]];
     [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.929 green:0.420 blue:0.416 alpha:0.350]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置tabBar选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor redColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor], NSForegroundColorAttributeName,
                                               nil]];

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
