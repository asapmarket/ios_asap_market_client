//
//  ShopCartBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopCartBaseModel.h"

@implementation ShopCartBaseModel
MJCodingImplementation

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"dataArray":[ShopCartModel class],
    
             };
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];

    }
    return _dataArray;
}

@end
