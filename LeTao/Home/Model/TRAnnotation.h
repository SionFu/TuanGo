//
//  TRAnnotation.h
//  LeTao
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface TRAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy ) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
//添加图片属性
@property (nonatomic, strong) UIImage *image;
@end
