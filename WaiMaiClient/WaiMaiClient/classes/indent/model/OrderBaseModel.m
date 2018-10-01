//
//  OrderBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderBaseModel.h"

@implementation OrderBaseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"rows":[OrderListModel class],
             };
}
@end
