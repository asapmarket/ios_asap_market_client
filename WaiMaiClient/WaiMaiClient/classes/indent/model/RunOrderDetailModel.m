//
//  RunOrderDetailModel.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderDetailModel.h"

@implementation RunOrderDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"rows":[RunOrderImgsModel class],
             };
}

@end
