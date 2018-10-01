//
//  OrderDetailStoreModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailFoodModel.h"

@interface OrderDetailStoreModel : NSObject

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@property (nonatomic, strong) NSString *foods_count;

@property (nonatomic, strong) NSMutableArray *foods_list;

@end
