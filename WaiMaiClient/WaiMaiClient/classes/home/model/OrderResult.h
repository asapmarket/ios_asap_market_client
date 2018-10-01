//
//  OrderResult.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderResult : NSObject

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *total_money;
@property (nonatomic, strong) NSMutableArray *store_ids;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@end
