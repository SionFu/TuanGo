//
//  TRMetaDataView.h
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMetaDataView : UIView
/**
 *  主视图
 */
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
/**
 *  辅助视图
 */
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

/**
 *  返回xib 取到的view
 */
+ (instancetype)getMetaDataView;
@end
