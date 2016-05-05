//
//  TRBaseTableViewController.h
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRBaseTableViewController : UIViewController

//声明表视图子类用这个表格初始化
@property (nonatomic,strong) UITableView* tableView;

//父类调用子类实现发送请求的参数
-(void)settingRequestparams:(NSMutableDictionary *)params;

//子类调用,父类实现发送请求方法
- (void)loadNewDeals;
@end
