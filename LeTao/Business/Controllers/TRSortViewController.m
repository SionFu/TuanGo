//
//  TRSortViewController.m
//  LeTao
//
//  Created by tarena on 16/5/4.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRSortViewController.h"
#import "TRMataDataTool.h"
#import "TRSort.h"
@interface TRSortViewController ()
@property (nonatomic ,strong) NSArray *sortArray;
@end

@implementation TRSortViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //修改弹出控制器的大小
    self.preferredContentSize = CGSizeMake(130, 330);

    //添加按钮
    [self addSortButton];
    //常量值
}
- (void)addSortButton{
    self.sortArray = [TRMataDataTool getAllSorts];
    TRSort *sort = [TRSort new];
    for (int i = 1; i <= _sortArray.count; i++) {
        sort = _sortArray[i-1];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15, i * 15 +(i-1)*30, 100, 30)];
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.view addSubview:button];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
