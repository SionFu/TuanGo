//
//  TRHoneHeadView.m
//  LeTao
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRHoneHeadView.h"
#import "TRMataDataTool.h"
#import "TRUIControl.h"
#import "TRMenuData.h"
@interface TRHoneHeadView ()
@property (nonatomic, strong) NSArray *menuData;
@end

@implementation TRHoneHeadView



- (NSArray *)menuData {
	if(_menuData == nil) {
		_menuData = [TRMataDataTool getAllMenuData];
	}
	return _menuData;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat secreenWith = [UIScreen mainScreen].bounds.size.width;
        //创建scrollview
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
        scrollView.contentSize = CGSizeMake(secreenWith * 2, secreenWith * 0.5);
        scrollView.pagingEnabled = YES;
        //创建firstView
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, secreenWith, secreenWith /2)];
        //创建secondview
        [scrollView addSubview:firstView];
        //两个for循环添加16个view
        
        CGFloat quartScreenWith = secreenWith * 0.25;
        for (int i = 0 ; i < 8; i ++) {
            CGRect constFrame = CGRectMake(quartScreenWith * (i%4), quartScreenWith * (i / 4), quartScreenWith, quartScreenWith );
            TRUIControl *control = [[[NSBundle mainBundle]loadNibNamed:@"TRUIControl" owner:self options:nil]firstObject];
            control.frame = constFrame;
            
            //设置文本和图片
            TRMenuData *menuData = self.menuData[i];
            control.imageView.image = [UIImage imageNamed:menuData.image];
            control.categorylabel.text = menuData.title;
            [firstView addSubview:control];
        }
        //两个firstView+secondView到scrollview
        
        [self addSubview:scrollView];
        
    }return self;
}
- (void)cliclControl:(UIControl *)control{
    //使用delegate
    if ([self.delegate respondsToSelector:@selector(clickHomeMenuButton:)]) {
        [self.delegate clickHomeMenuButton:control.tag];
    }
}

//通过button的tag值，知道点击哪个button
- (void)clickButton:(UIButton *)sender {
    NSLog(@"999999999999 ---- %ld", (long)sender.tag);
    if ([self.delegate respondsToSelector:@selector(clickHomeMenuButton:)]) {
        [self.delegate clickHomeMenuButton:(NSInteger)sender.tag];
    }
}

@end
