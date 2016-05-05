//
//  TRRegionViewController.m
//  LeTao
//
//  Created by tarena on 16/5/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRRegionViewController.h"
#import "TRMataDataTool.h"
#import "TRMetaDataView.h"
#import "TRRegion.h"
#import "TRTableViewCell.h"
@interface TRRegionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *regionArray;
//记录view
@property (nonatomic,strong)TRMetaDataView *mateDataView;
@end
@implementation TRRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(260, 400);
#warning 硬编码
    self.regionArray = [TRMataDataTool getAllRegionsCityName:@"衢州"];
   
    //创建并添加mateDataView
    [self addMetaDataView];
}
- (void)addMetaDataView{
    self.mateDataView = [TRMetaDataView getMetaDataView];
    self.mateDataView.mainTableView.dataSource = self;
    self.mateDataView.mainTableView.delegate = self;
    self.mateDataView.subTableView.dataSource = self;
    self.mateDataView.subTableView.delegate = self;
    self.view =self.mateDataView;
}
#pragma mark -- 获取选中单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mateDataView.mainTableView) {
        [self.mateDataView.subTableView reloadData];
    }
}

#pragma mark -- DataSource / Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.mateDataView.mainTableView) {
        
        return self.regionArray.count;
        
    }else{
        //右边的视图
        //获取左边选中的行号(行号)和数组下标 -- 对应)
       NSInteger selectedRow = [self.mateDataView.mainTableView indexPathForSelectedRow].row;
        //获取这个行号里面内容的个数
        TRRegion *regin = self.regionArray[selectedRow];
        return regin.subregions.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.mateDataView.mainTableView) {
        //左边
        //1.获取数据
        TRTableViewCell *cell = [TRTableViewCell cellWithTableView:tableView withImageName:@"bg_dropdown_leftpart" withSelectedImageName:@"bg_dropdown_left_selected"];
        //2.数据源
        TRRegion *region = self.regionArray[indexPath.row];
        //3.赋值
        cell.textLabel.text = region.name;
        if (region.subregions.count > 0) {
            //有子区域
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            //没有子区域
             cell.accessoryType = UITableViewCellAccessoryNone;
        }return cell;
        
    }else{
        //右边
        TRTableViewCell *cell = [TRTableViewCell cellWithTableView:tableView withImageName:@"bg_dropdown_rightpart" withSelectedImageName:@"bg_dropdown_right_selected"];
        //右边的行号 区域模型对象;赋值
        NSInteger selectedRow = [self.mateDataView.mainTableView indexPathForSelectedRow].row;
        TRRegion *region = self.regionArray[selectedRow];
        cell.textLabel.text = region.subregions[indexPath.row];
        return cell;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
