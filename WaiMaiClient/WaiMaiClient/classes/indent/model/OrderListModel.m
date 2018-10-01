//
//  OrderListModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"store_list":[OrderModel class],
             };
}

@end
