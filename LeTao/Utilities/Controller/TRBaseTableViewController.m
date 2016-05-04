//
//  TRBaseTableViewController.m
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRBaseTableViewController.h"
#import "DPAPI.h"
#import "TRMataDataTool.h"
#import "TRMainTableViewCell.h"
#import "TRDeal.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"//上下拉刷新控件
@interface TRBaseTableViewController ()<DPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
//记录所有的订单的数组
@property (nonatomic,strong)NSMutableArray *dealsArray;
@property (nonatomic,assign)int page;
//记录最新一次请求的对象
@property (nonatomic,strong) DPRequest *lastesRequest;
@end

@implementation TRBaseTableViewController
-(NSMutableArray *)dealsArray{
    if (!_dealsArray) {
        _dealsArray = [NSMutableArray array];
    }return _dealsArray;
}

- (void)viewDidLoad {
     [super viewDidLoad];
    
    //创建并添加TableView
    [self setUpTableView];
    
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TRMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"DealCell"];
    
    //创建上拉下拉两个控件
    [self AddRefreshControl];
    
    //发送数据查询
    [self sendRequestToServer];


}




- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    //获取数据失败停止刷新
    
    //停止下拉刷新
    [self.tableView.mj_header endRefreshing];
    //停止上拉刷新
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark -- DataSource ViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dealsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    //注册好的单元格
    TRMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    //数据源
    TRDeal *deal = self.dealsArray[indexPath.row];
    //赋值
    cell.deal =  deal;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101; 
}
#pragma mark -- 和界面相关的方法
-(void)AddRefreshControl{
    //下拉刷新
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDeals)];
    //执行刷新的动作
    [self.tableView.mj_header beginRefreshing];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDeal)];
    
}
-(void)setUpTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark -- 和网络相关

//下拉刷新
- (void)loadNewDeals{
    //page = 1
    self.page = 1;
    [self sendRequestToServer];
}
//上拉刷新
- (void)loadMoreDeal{
    //page++
    self.page ++;
    [self sendRequestToServer];
}
//获取数据
-(void)sendRequestToServer{
    DPAPI *api = [DPAPI new];
    //给定城市参数
    /**
     *  调用子类的设置参数逻辑(方法)
     主页:用户选择哪个按钮City
     
     */
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [self settingRequestparams:paramsDic];
    //添加page参数
    paramsDic[@"page"] = @(self.page);
//    paramsDic[@"city"] = @"衢州";
    NSLog(@"%@",paramsDic[@"page"]);
    //把最后一次请求对象记录
    self.lastesRequest = [api requestWithURL:@"v1/deal/find_deals" params:paramsDic delegate:self];
}
#pragma mark -DPREquestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *array = [TRMataDataTool parseDealsResult:result];
    
    //如果服务器返回的request不等于最新的 一次数据,就不处理
    if (self.lastesRequest != request) {
        return;
    }
    
    //每次页面数为1时清除所有数据,切换到(其他类)电影时清除原来的数据
    if (self.page == 1) {
        [self.dealsArray removeAllObjects];
    }
    //每次添加上拉刷新时添加数据
    [self.dealsArray addObjectsFromArray:array];
    
    
    [self.tableView reloadData];
    //停止下拉刷新
    [self.tableView.mj_header endRefreshing];
    //停止上拉刷新
    [self.tableView.mj_footer endRefreshing];
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
