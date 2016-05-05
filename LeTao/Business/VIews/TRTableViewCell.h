//
//  TRTableViewCell.h
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRTableViewCell : UITableViewCell
/**
 *  给定tablView 两个背景图片的名字 返回TRTableViewCell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView withImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectedImageName;
@end
