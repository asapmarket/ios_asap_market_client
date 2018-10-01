//
//  SpecClassListModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SpecClassListModel.h"

@implementation SpecClassListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
                @"spec_list":[SpecListModel class]
             };
}

- (NSMutableArray *)spec_list{
    if (!_spec_list) {
        _spec_list = [NSMutableArray array];
    }
    return _spec_list;
}

@end
