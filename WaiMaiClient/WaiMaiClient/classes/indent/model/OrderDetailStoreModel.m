//
//  OrderDetailStoreModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderDetailStoreModel.h"

@implementation OrderDetailStoreModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
                @"foods_list":[OrderDetailFoodModel class]
             };
    
}

@end
