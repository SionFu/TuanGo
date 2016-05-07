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
#import "TRRegion.h"
#import "TRCategory.h"
#import "TRCity.h"
#import "TRMataDataTool.h"


@interface TRBusinessViewController ()<UIPopoverPresentationControllerDelegate>
//记录头部视图
@property (nonatomic,strong) TRBusinessHeadView *headerView;

//记录排序控制器
@property (nonatomic,strong) TRSortViewController *sortViewController;

//记录区域控制器
@property (nonatomic,strong) TRRegionViewController *regionViewController;

//记录分类控制器
@property (nonatomic,strong) TRCategoryViewController *categoryViewController;

//记录记录所有用户选择的值(排序+分类+区域+城市)
@property (nonatomic, strong) NSNumber *sortValue;

//主区域的名字
@property (nonatomic, strong) NSString *mainRegionName;

//子区域的名字
@property (nonatomic, strong) NSString *subRegionName;

//主分类名字
@property (nonatomic, strong) NSString *mainCategoryName;
//子分类名字
@property (nonatomic, strong) NSString *subCategoryName;
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
    
    //添加通知监听方法
    [self listenNotifications];
    
    //添加左上角item
    [self setUpItem];
    

}
#pragma mark --和通知相关的方法
- (void)listenNotifications {
    //监听排序
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortDidChange:) name:@"TRSortDidChange" object:nil];
    //监听区域
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regionDidChange:) name:@"TRRegionDidChange" object:nil];
    //监听分类
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryDidChange:) name:@"TRCategoryDidChange" object:nil];
}


- (void)sortDidChange:(NSNotification *)notification {
    //获取参数 (类型:发送端决定)
    NSNumber *sortValue = notification.userInfo[@"SortValue"];
    //设置参数(settingRe)
    self.sortValue = sortValue;
    [self loadNewDeals];
    
}

//获得选中的城市
- (void)regionDidChange:(NSNotification *)notification {
    //获取参数(主区域+子区域)
    TRRegion *region = notification.userInfo[@"MainRegion"];
    NSString *subRegin = notification.userInfo[@"SubReginName"];
    //设置参数(判断子区域+排序"全部")
    
    if ([region.name isEqualToString: @"全部"]) {
        self.mainRegionName = nil;
        
    }else{
        if (subRegin == nil) {
            self.subRegionName = region.name;
        }else{
            self.subRegionName = subRegin;
        }
    }
    
    //发送数据请求
    [self loadNewDeals];
}
- (void)categoryDidChange:(NSNotification *)notification {
        //获取参数
    TRCategory *cate = notification.userInfo[@"MainCategory"];
    NSString *subCate = notification.userInfo[@"SubCategoryName"];
    
    if ([cate.name isEqualToString:@"全部分类"]) {
        //点中全部
        self.mainCategoryName = nil;
    }else{
        if (subCate == nil) {
            self.mainCategoryName = cate.name;
        }else{
            self.subCategoryName = subCate;
        }
    }
    [self loadNewDeals];
}

#pragma mark -- 和界面相关

- (void)setUpItem{
    //创建左上角item项目
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc]initWithTitle:[TRMataDataTool getSelectedCityName] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.leftBarButtonItem = cityItem;
}

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
    //设置界面上的 区域 分类 城市  排序
#warning TOOO:设置四个参数
    //可以获取到城市的名字(定位 +  用户自定义选择)
    //城市
    if ([TRMataDataTool getSelectedCityName]) {
        params[@"city"] = [TRMataDataTool getSelectedCityName];
    }else{
        //获取不到位置的时候直接用北京为默认城市
        params[@"city"] = @"北京";
    }
    
    //设置分类
    if (self.mainCategoryName) {
        //有子分类
        params[@"category"] = self.subCategoryName;
    }else{
        //没有子分类
        params[@"category"] = self.subCategoryName;
    }
    
    
    
    //设置区域
    if (self.mainRegionName) {
        if (self.subRegionName) {
            //有子区域
            params[@"region"] = self.subRegionName;
        }else{
            //没有子区域
            params[@"region"] = self.mainRegionName;
        }
    }
    

    //设置排序
    if (self.sortValue) {
       params[@"sort"]  = self.sortValue;
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
