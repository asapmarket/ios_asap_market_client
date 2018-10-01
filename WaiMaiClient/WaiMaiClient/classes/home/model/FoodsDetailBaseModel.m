//
//  FoodsDetailBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodsDetailBaseModel.h"

@implementation FoodsDetailBaseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"spec_class_list":[FoodDetailSpecModel class],
             @"foods_detail":[FoodDetailModel class]
             };
}

- (NSString *)has_spec{
    if (!_has_spec) {
        _has_spec = @"0";
    }
    return _has_spec;
}

@end
