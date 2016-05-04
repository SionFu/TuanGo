//
//  TRDeal.h
//  LeTao
//
//  Created by tarena on 16/5/3.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDeal : NSObject
/**
 *  KVC自动绑定字典的key一样
 */

/**
 *  订单标题
 */
@property (nonatomic,copy) NSString *title;
/**
 * 订单的详细描述人为干预KVC绑定(第三方库简单)
 */
@property (nonatomic,copy) NSString *desc;
/**
 *  订单原价格
 */
@property (nonatomic,strong) NSNumber *list_price;
/**
 * 订单团队价格
 */
@property (nonatomic,strong) NSNumber *current_price;
/**
 * 订单所属分类
 */
@property (nonatomic,strong) NSArray *categories;
/**
 * 订单购买个数
 */
@property (nonatomic,strong) NSNumber *purchase_count;
/**
 * 订单对应小图的url
 */
@property (nonatomic,strong) NSString *s_image_url;
/**
 * 订单详情h5页面
 */
@property (nonatomic,strong) NSString *deal_h5_url;
/**
 * 订单对应的商家数组
 */
@property (nonatomic,strong) NSArray *businesses;












@end
