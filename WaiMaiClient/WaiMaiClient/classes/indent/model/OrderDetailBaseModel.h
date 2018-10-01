//
//  OrderDetailBaseModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailStoreModel.h"

@interface OrderDetailBaseModel : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *is_urge;
@property (nonatomic, strong) NSString *exp_id;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;
@property (nonatomic, strong) NSString *exp_name;
@property (nonatomic, assign) double exp_lng;
@property (nonatomic, assign) double exp_lat;

@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *yunfei;
@property (nonatomic, strong) NSString *total_money;
@property (nonatomic, strong) NSString *create_time;


@property (nonatomic, strong) NSMutableArray *store_list;

@end
