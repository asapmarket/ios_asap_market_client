//
//  RunUserPointParam.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunUserPointParam : NSObject
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *token;
@end

@interface WMUserCouponsParam : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *COUPON_NUM;
@property (nonatomic, strong) NSString *yunfei;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *total_money;

@end

@interface WMUserCouponsModel : NSObject

@property (nonatomic, strong) NSString *COUPON_ID;
@property (nonatomic, strong) NSString *COUPON_NUM;
@property (nonatomic, strong) NSString *COUPON_MONEY;
@property (nonatomic, assign) NSInteger STATUS;
@property (nonatomic, strong) NSString *USER_ID;
@property (nonatomic, strong) NSString *yunfei;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *total_money;

@end
