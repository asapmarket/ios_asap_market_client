//
//  FoodDetailSpecModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodDetailSpecModel.h"

@implementation FoodDetailSpecModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"spec_list":[FoodDetailSpecListModel class]
             };
}

@end
