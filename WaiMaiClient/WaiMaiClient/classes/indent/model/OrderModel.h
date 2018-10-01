//
//  OrderModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@property (nonatomic, strong) NSString *quantity;

@end
