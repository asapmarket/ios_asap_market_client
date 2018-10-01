//
//  RunOrderDetailModel.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunOrderModel.h"

@interface RunOrderDetailModel : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *exp_id;
@property (nonatomic, assign) double exp_lat;
@property (nonatomic, assign) double exp_lng;
@property (nonatomic, strong) NSString *exp_name;
@property (nonatomic, strong) NSString *total_money;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *cust_address;
@property (nonatomic, strong) NSString *cust_name;
@property (nonatomic, strong) NSString *cust_phone;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *yunfei;
@property (nonatomic, strong) NSString *point;
@property (nonatomic, assign) NSInteger pay_state;
@property (nonatomic, assign) NSInteger payment_method;
@end
