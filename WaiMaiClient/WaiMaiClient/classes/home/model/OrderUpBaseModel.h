//
//  OrderUpBaseModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderUpModel.h"

@interface OrderUpBaseModel : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) OrderUpModel *order;
@property (nonatomic, strong) NSString *COUPON_NUM;
@property (nonatomic, strong) NSString *COUPON_MONEY;


@end
