//
//  OrderUpBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderUpBaseModel.h"

@implementation OrderUpBaseModel

- (OrderUpModel *)order{
    if (!_order) {
        _order = [[OrderUpModel alloc] init];
    }
    return _order;
}

@end
