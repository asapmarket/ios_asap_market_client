//
//  ShopCartModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreDetailModel.h"
#import "StoreGoodsBaseModel.h"

@interface ShopCartModel : QKCoding

@property (nonatomic, strong) NSString *specAllId;
@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@property (nonatomic, strong) NSString *store_image;

@property (nonatomic, strong) NSString *food_id;
@property (nonatomic, strong) NSString *foods_name_cn;
@property (nonatomic, strong) NSString *foods_name_en;
@property (nonatomic, strong) NSString *foods_image_cn;
@property (nonatomic, strong) NSString *foods_image_en;
@property (nonatomic, strong) NSString *price;

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int specCount;

@property (nonatomic, strong) NSString *specName_cn;
@property (nonatomic, strong) NSString *specName_en;




@end
