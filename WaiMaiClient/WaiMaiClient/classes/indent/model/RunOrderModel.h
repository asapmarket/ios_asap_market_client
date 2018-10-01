//
//  RunOrderModel.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/15.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunOrderModel : NSObject

@property (nonatomic, strong) NSMutableArray *rows;

@end

@interface RunOrderItem : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *exp_name;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, assign) NSInteger pay_state;
@property (nonatomic, assign) NSInteger payment_method;

@end

@interface RunOrderImgsModel : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *sort;

@end
