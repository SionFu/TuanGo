//
//  TRHoneHeadView.h
//  LeTao
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义"主页"按钮点击协议
@protocol  TRHomeMenuButtonDelegate <NSObject>
//@optional
- (void)clickHomeMenuButton:(long)sender;
@end





@interface TRHoneHeadView : UIView
//声明遵循协议的代码属性
@property(nonatomic, weak) id<TRHomeMenuButtonDelegate> delegate;

//重写UIView的initWithFrame方法来创建自定义的视图

@end
