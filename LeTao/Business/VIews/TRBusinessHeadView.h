//
//  TRBusinessHeadView.h
//  LeTao
//
//  Created by tarena on 16/5/4.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRBusinessHeadView : UIView
/**
 *  全部分类
 */
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
/**
 *  全部区域
 */
@property (weak, nonatomic) IBOutlet UIButton *regionButton;
/**
 *  全部排序
 */
@property (weak, nonatomic) IBOutlet UIButton *sortButton;

@end
