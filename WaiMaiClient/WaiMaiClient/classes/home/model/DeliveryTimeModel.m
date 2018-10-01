//
//  DeliveryTimeModel.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import "DeliveryTimeModel.h"

@implementation DeliveryTimeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[DeliveryTimeItem class],
             };
}
@end

@implementation DeliveryTimeItem

@end
