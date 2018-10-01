//
//  FoodsListModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpecClassListModel.h"

@interface FoodsListModel : QKCoding

@property (nonatomic, strong) NSString *foods_id;
@property (nonatomic, strong) NSString *foods_name_cn;
@property (nonatomic, strong) NSString *foods_name_en;
@property (nonatomic, strong) NSString *foods_image_cn;
@property (nonatomic, strong) NSString *foods_image_en;
@property (nonatomic, strong) NSString *foods_desc_cn;
@property (nonatomic, strong) NSString *foods_desc_en;
@property (nonatomic, strong) NSString *has_spec;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *store_id;

@property (nonatomic, strong) NSMutableArray *spec_class_list;

@property (nonatomic, assign) int count;

@property (nonatomic, assign) int specCount;

@property (nonatomic, strong) NSString *specAllID;

@property (nonatomic, strong) NSString *specName_cn;
@property (nonatomic, strong) NSString *specName_en;


@property (nonatomic, assign) BOOL isSelect;


@end
