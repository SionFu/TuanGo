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
#import "FDSGroupTableViewController.h"
#import "TRBaseNavController.h"
#import "TRMapViewController.h"
#import "TRHoneHeadView.h"
#import "TRMenuData.h"
@interface TRHomeViewController ()<TRHomeMenuButtonDelegate>
@property (nonatomic,strong)UIBarButtonItem *itemBar;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic,strong)NSString *categoryName;
@end

@implementation TRHomeViewController
- (NSArray *)menuArray {
    if(_menuArray == nil) {
        _menuArray = [TRMataDataTool getAllMenuData];
    }
    return _menuArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserCityName];
    [self addCityGroupbar];
    [self addMapView];
    [self setUpHomeHeadView];
}


- (void)setUpHomeHeadView{
    CGFloat ScreenWith = [UIScreen mainScreen].bounds.size.width;
    TRHoneHeadView *headView = [[TRHoneHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith  / 2)];
    self.tableView.tableHeaderView = headView;
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
}
- (void)clickHomeMenuButton:(long)sender{
    //通过tag值取到分类的名字
    TRMenuData *menuData  = self.menuArray[sender - 1000];
    //重新设置分类参数
    self.categoryName = menuData.title;
    //重新发送请求
    [self loadNewDeals];
    
}
- (void)addMapView{
    UIBarButtonItem *mapItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_map"] style:UIBarButtonItemStyleDone target:self action:@selector(clickMapButton)];
    self.navigationItem.rightBarButtonItem = mapItem;
}
- (void)clickMapButton{
   TRBaseNavController *mapView = [[TRBaseNavController alloc]initWithRootViewController:[TRMapViewController new]];
    [self presentViewController:mapView animated:YES completion:nil];
    
}
- (void)addCityGroupbar {
    self.itemBar = [[UIBarButtonItem alloc]initWithTitle:@"城市" style:UIBarButtonItemStyleDone target:self action:@selector(showCity)];
    self.navigationItem.leftBarButtonItem = self.itemBar;
     }
-(void)showCity{
    TRBaseNavController *groupView = [[TRBaseNavController alloc]initWithRootViewController:[FDSGroupTableViewController new]];
    [self presentViewController:groupView animated:YES completion:nil];
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
   
    if (self.categoryName) {
        params[@"category"] = self.categoryName;
    }else{
    params[@"category"] = @"美食";
    }
    
    if ([TRMataDataTool getSelectedCityName]) {
        params[@"city"] = [TRMataDataTool getSelectedCityName];
    }else{
         params[@"city"] = @"北京";
    }
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
