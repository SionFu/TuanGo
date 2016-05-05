//
//  TRTableViewCell.m
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRTableViewCell.h"

@implementation TRTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView withImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectedImageName{
    //重用机制
    static NSString *identifer = @"cell";
    TRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[TRTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //设置cell字体大小 背景图片
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    //选中后的图片
    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:selectedImageName]];
    
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
