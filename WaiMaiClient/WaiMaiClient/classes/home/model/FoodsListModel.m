//
//  FoodsListModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodsListModel.h"


@implementation FoodsListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
                @"spec_class_list":[SpecClassListModel class]
             };
}

- (NSMutableArray *)spec_class_list{
    if (!_spec_class_list) {
        _spec_class_list = [NSMutableArray array];
    }
    return _spec_class_list;
}

@end
