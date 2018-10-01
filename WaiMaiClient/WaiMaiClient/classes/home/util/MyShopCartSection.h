//
//  MyShopCartSection.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodsListModel.h"
#import "StoreDetailModel.h"

@interface MyShopCartSection : NSObject


@property (nonatomic, strong) StoreDetailModel *detailModel;
@property (nonatomic, strong) NSMutableArray *food_list;

@property (nonatomic, assign) BOOL isSelect;

@end
