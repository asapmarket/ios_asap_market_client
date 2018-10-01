//
//  MyShopCartBaseModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartBaseModel.h"
#import "MyShopCartSection.h"

@interface MyShopCartBaseModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

+ (NSMutableArray *)getMyShopCartBaseModel:(ShopCartBaseModel *)baseModel;

@end
