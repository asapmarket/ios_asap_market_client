//
//  AmoutModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/9/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface AmoutModel : NSObject

@property (nonatomic, strong) NSString *count_words_cn;
@property (nonatomic, strong) NSString *count_words_en;
@property (nonatomic, strong) NSString *money_limit; //0:不满足最低消费
@property (nonatomic, strong) NSString *point_balance;
@property (nonatomic, strong) AddressModel *default_address;

@property (nonatomic, strong) NSMutableArray *store_ids;
@property (nonatomic, strong) NSString *yunfei;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *total_money;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;


@end
