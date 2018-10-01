//
//  OrderUpModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpStoreListModel.h"

@interface OrderUpModel : NSObject

@property (nonatomic, strong) NSString *payment_method;  //支付方式 0：visa 1:paypal 2:余额
@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *extm_id;

@property (nonatomic, strong) NSString *distribution_time;

@property (nonatomic, strong) NSMutableArray *store_list;
@end
