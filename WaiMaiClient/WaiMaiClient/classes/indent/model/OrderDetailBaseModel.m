//
//  OrderDetailBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderDetailBaseModel.h"

@implementation OrderDetailBaseModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
                @"store_list":[OrderDetailStoreModel class]
             };
}

@end
