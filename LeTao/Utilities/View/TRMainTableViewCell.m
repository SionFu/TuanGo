//
//  TRMainTableViewCell.m
//  LeTao
//
//  Created by tarena on 16/5/4.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRMainTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface TRMainTableViewCell ()
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;
/**
 *  订单描述
 */
@property (weak, nonatomic) IBOutlet UILabel *dealDescLabel;
/**
 *  团购价格
 */
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
/**
 *  折扣
 */
@property (weak, nonatomic) IBOutlet UIButton *discountButton;
/**
 *  已售数量
 */
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;


@end

@implementation TRMainTableViewCell
-(void)setDeal:(TRDeal *)deal{
    //设置图片
    [self.dealImageView sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url]];
    //标题
    self.dealDescLabel.text = deal.title;
    //团购价格
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥%@",deal.current_price];
    //原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥%@",deal.list_price];
    
    //显示折扣
    float discount = [deal.current_price floatValue] / [deal.list_price floatValue] *10;
    [self.discountButton setTitle:[NSString stringWithFormat:@"%.01f折",discount] forState:UIControlStateNormal];
    
    //显示已售数量
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%@单",deal.purchase_count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
