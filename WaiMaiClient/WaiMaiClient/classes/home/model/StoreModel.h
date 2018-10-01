//
//  StoreModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@property (nonatomic, strong) NSString *store_address_cn;
@property (nonatomic, strong) NSString *store_address_en;
@property (nonatomic, strong) NSString *store_desc_cn;
@property (nonatomic, strong) NSString *store_desc_en;
@property (nonatomic, strong) NSString *store_image;

@property (nonatomic, assign) BOOL onwork;

@end
