//
//  OrderListModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@interface OrderListModel : NSObject

@property (nonatomic, strong) NSMutableArray *store_list;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *exp_name;
@property (nonatomic, strong) NSString *is_urge;

@end
