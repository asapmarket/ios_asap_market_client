//
//  ShopCartManager.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartBaseModel.h"
#import "ShopCartModel.h"
#import "YPTabItem.h"

#define ShopCartResponseFile  @"ShopCartResponseFile"

@interface ShopCartManager : NSObject

//@property (nonatomic, strong) ShopCartBaseModel *baseModel;

+ (ShopCartManager *)shareManager;

- (void)addObjectWithShopCartModel:(ShopCartModel *)model;

- (void)removeObjectWithShopCartModel:(ShopCartModel *)model;

- (ShopCartBaseModel *)loadShopCartBaseModel;

- (void)deleteUnWorkStoreWithArray:(NSArray *)array;

@property (nonatomic, strong) YPTabItem *tabBar;

- (void)setShopCartCount:(int)count;
/**
 清空购物车
 */
- (void)clearShopCart;
@end
