//
//  TRSearchViewController.m
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRSearchViewController.h"

@interface TRSearchViewController ()<UISearchBarDelegate>

@end

@implementation TRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加UISearchBar控件
    UISearchBar *searchBar = [UISearchBar new];
    //设置placeHolder 文本 (提示文本)
    
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入商品名、商户名、地址等";
    //添加
    self.navigationItem.titleView = searchBar;
    //右边添加一个项目使搜索框居中
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}
//监听用户点击search/搜索按钮时机
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //发送请求
    [self loadNewDeals];
    //收回键盘
    [searchBar resignFirstResponder];
}
//子类实现settingparams 方法,设置参数
- (void)settingRequestparams:(NSMutableDictionary *)params{
    params[@"city"] = @"北京";

    UISearchBar *bar = (UISearchBar *)self.navigationItem.titleView;
    if (bar.text.length == 0) {
        params[@"keyword"] = @"西部马华";
    }else{
    params[@"keyword"] = bar.text;
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
