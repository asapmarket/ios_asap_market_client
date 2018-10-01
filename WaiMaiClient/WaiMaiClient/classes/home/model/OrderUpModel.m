//
//  OrderUpModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderUpModel.h"

@implementation OrderUpModel

- (NSMutableArray *)store_list{
    if (!_store_list) {
        _store_list = [NSMutableArray array];
    }
    return _store_list;
}

@end
