//
//  RunOrderModel.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/15.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderModel.h"

@implementation RunOrderModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"rows":[RunOrderItem class],
             };
}

@end


@implementation RunOrderItem

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"rows":[RunOrderImgsModel class],
             };
}

@end

@implementation RunOrderImgsModel

@end

