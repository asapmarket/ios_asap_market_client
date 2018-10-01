//
//  HomeMainModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeMainModel.h"

@implementation HomeMainModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"banner_list":[ImageModel class],
             @"type_list" :[StoreTypeModel class],
             @"hot_foods" :[HotFoodsModel class],
             };
}
@end
