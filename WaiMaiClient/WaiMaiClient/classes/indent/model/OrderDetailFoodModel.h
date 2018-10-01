//
//  OrderDetailFoodModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailFoodModel : NSObject

@property (nonatomic, strong) NSString *foods_id;
@property (nonatomic, strong) NSString *foods_name_cn;
@property (nonatomic, strong) NSString *foods_name_en;
@property (nonatomic, strong) NSString *foods_quantity;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *state;

@end
