//
//  SpecIDBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/7.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SpecIDBaseModel.h"

@implementation SpecIDBaseModel

- (NSMutableArray *)specClassID_list{
    if (!_specClassID_list) {
        _specClassID_list = [NSMutableArray array];
    }
    return _specClassID_list;
}

@end
