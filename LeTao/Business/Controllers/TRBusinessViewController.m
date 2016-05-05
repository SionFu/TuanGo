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
#import "TRSortViewController.h"
#import "TRRegionViewController.h"
#import "TRCategoryViewController.h"
#import "TRSearchViewController.h"

@interface TRBusinessViewController ()<UIPopoverPresentationControllerDelegate>
//记录头部视图
@property (nonatomic,strong) TRBusinessHeadView *headerView;

//记录排序控制器
@property (nonatomic,strong) TRSortViewController *sortViewController;

//记录区域控制器
@property (nonatomic,strong) TRRegionViewController *regionViewController;

//记录分类控制器
@property (nonatomic,strong) TRCategoryViewController *categoryViewController;
@end

@implementation TRBusinessViewController
//懒加载
- (TRSortViewController *)sortViewController{
    if (!_sortViewController) {
        _sortViewController = [TRSortViewController new];
    }return _sortViewController;
}
- (TRRegionViewController *)regionViewController {
    if(_regionViewController == nil) {
        _regionViewController = [[TRRegionViewController alloc] init];
    }
    return _regionViewController;
}

- (TRCategoryViewController *)categoryViewController {
    if(_categoryViewController == nil) {
        _categoryViewController = [[TRCategoryViewController alloc] init];
    }
    return _categoryViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建/添加头视图
    [self setUpHeaderView];
    
    //给三个button添加action
    [self addTargetsForButton];
}

#pragma mark -- 和界面相关

- (void)addTargetsForButton{
    //给排序按钮添加方法
    [self.headerView.sortButton addTarget:self action:@selector(clickSortButton) forControlEvents:UIControlEventTouchUpInside];
    //给全部区域添加
    [self.headerView.regionButton addTarget:self action:@selector(clickRegionButton) forControlEvents:UIControlEventTouchUpInside];
    //给区域分类添加方法
    [self.headerView.categoryButton addTarget:self action:@selector(clickCategoryButton) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setUpHeaderView{
    //创建
    //直接添加nib视图 返回多个视图
    _headerView = [[[NSBundle mainBundle]loadNibNamed:@"TRBusinessHeadView" owner:nil options:nil]firstObject];
    //设置frame   添加
    _headerView.frame = CGRectMake(0, 64, self.view.frame.size.width, 50);
    [self.view addSubview:_headerView];
    //设置父类tableView的y值
    self.tableView.y = 40;
}

#pragma mark -- 按钮的触发的方法

- (IBAction)searchButtonClick:(id)sender {
    TRSearchViewController *searchVC = [[TRSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}
- (void)clickCategoryButton {
    
    self.categoryViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.categoryViewController.popoverPresentationController.sourceView = self.headerView.categoryButton;
    self.categoryViewController.popoverPresentationController.sourceRect = self.headerView.categoryButton.bounds;
    self.categoryViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    //防止在iphone上显示全屏，需要实现delegate方法
    self.categoryViewController.popoverPresentationController.delegate = self;
    
    //显示
    [self presentViewController:self.categoryViewController animated:YES completion:nil];
    
}

- (void)clickRegionButton {
    self.regionViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.regionViewController.popoverPresentationController.sourceView = self.headerView.regionButton;
    self.regionViewController.popoverPresentationController.sourceRect = self.headerView.regionButton.bounds;
    self.regionViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.regionViewController.popoverPresentationController.delegate = self;
    
    //显示
    [self presentViewController:self.regionViewController animated:YES completion:nil];
}
- (void)clickSortButton {
    //创建排序控制器对象(懒加载)
    //设置属性(样式；显示相对位置；具体箭头的位置；箭头方向)
    self.sortViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.sortViewController.popoverPresentationController.sourceView = self.headerView.sortButton;
    self.sortViewController.popoverPresentationController.sourceRect = self.headerView.sortButton.bounds;
    //设置箭头的显示方向(Any:自动寻找最优的方向)
    self.sortViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    //iPhone版本需要设置delegate
    self.sortViewController.popoverPresentationController.delegate = self;
    //显示present
    [self presentViewController:self.sortViewController animated:YES completion:nil];
}


#pragma maek -- popOver Delegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
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
