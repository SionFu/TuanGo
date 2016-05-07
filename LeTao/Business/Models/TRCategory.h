//
//  TRCategory.h
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCategory : NSObject
/**
 * 高亮的ico
 */
@property (nonatomic,strong) NSString *highlighted_icon;
/**
 * ico
 */
@property (nonatomic,strong) NSString *icon;
/**
 * 名字
 */
@property (nonatomic,strong) NSString *name;
/**
 * small_highlighted_icon
 */
@property (nonatomic,strong) NSString *small_highlighted_icon;
/**
 * small_icon
 */
@property (nonatomic,strong) NSString *small_icon;
/**
 *  要添加在地图上的本地图片
 */
@property (nonatomic, strong) NSString *map_icon;

/**
 * 主区域对应子区域的名字数组
 */
@property (nonatomic,strong) NSArray *subcategories;
@end
