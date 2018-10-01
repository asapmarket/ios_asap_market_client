//
//  OrderDetailFoodModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderDetailFoodModel.h"

@implementation OrderDetailFoodModel

- (void)setState:(NSString *)state{
    _state = state;
    if ([state isEqualToString:@"0"]) {
        _state = NSLocalizedString(kInGet, nil);
    }else if([state isEqualToString:@"1"]){
        _state = NSLocalizedString(kGetSuccess, nil);
    }
}

@end
