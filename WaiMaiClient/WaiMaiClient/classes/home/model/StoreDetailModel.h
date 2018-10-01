//
//  StoreDetailModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreDetailModel : QKCoding

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@property (nonatomic, strong) NSString *store_address_cn;
@property (nonatomic, strong) NSString *store_address_en;
@property (nonatomic, strong) NSString *business_hours_cn;
@property (nonatomic, strong) NSString *business_hours_en;
@property (nonatomic, strong) NSString *has_collect; // 0：没有 1：已收藏
@property (nonatomic, strong) NSString *store_image;
@property (nonatomic, strong) NSString *store_desc_cn;
@property (nonatomic, strong) NSString *store_desc_en;
@property (nonatomic, assign) BOOL onwork;

@end
