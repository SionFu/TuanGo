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
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.tag = i-1 ;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickButton:(UIButton *)button {
    
    //1.发送通知(参数1~7)
    /**
     *  发送sort值和tag的直接关系 sort = tag  sort = self.sortArray[tag].value;
     */
    //1.1
    TRSort *sort = self.sortArray[button.tag];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TRSortDidChange" object:self userInfo:@{@"SortValue":sort.value}];
    //收回控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
