//
//  HomeMainModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"
#import "StoreTypeModel.h"
#import "HotFoodsModel.h"
@interface HomeMainModel : NSObject

/**
 banner
 */
@property (nonatomic, strong) NSMutableArray *banner_list;

/**
 店家类型
 */
@property (nonatomic, strong) NSMutableArray *type_list;

/**
 热门商品
 */
//@property (nonatomic, strong) NSMutableArray *hot_foods;

@end
