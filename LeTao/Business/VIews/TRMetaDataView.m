//
//  TRMetaDataView.m
//  LeTao
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRMetaDataView.h"

@implementation TRMetaDataView

+ (instancetype)getMetaDataView{
    return [[[NSBundle mainBundle]loadNibNamed:@"TRMetaDataView" owner:self options:nil]lastObject];
}
@end
