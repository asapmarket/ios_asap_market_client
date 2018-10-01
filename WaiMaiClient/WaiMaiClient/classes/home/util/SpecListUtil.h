//
//  SpecListUtil.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodsListModel.h"
#import "SpecIDBaseModel.h"
#import "ShopCartManager.h"

@interface SpecListUtil : NSObject

+ (SpecIDBaseModel *)getSpecWithFoodListModel:(FoodsListModel *)model classModel:(SpecClassListModel *)classModel listModel:(SpecListModel *)listModel specIdModel:(SpecIDBaseModel *)id_base_model;

+ (NSString *)getSpecWithIDBaseModel:(SpecIDBaseModel *)model;

+ (SpecIDBaseModel *)getDefaultSpecClassIDModel:(FoodsListModel *)model;

+ (int)stringComparison:(NSString *)specAllID;

+ (NSString *)getSpecNameCNWithIDBaseModel:(SpecIDBaseModel *)model;

+ (NSString *)getSpecNameENWithIDBaseModel:(SpecIDBaseModel *)model;



@end
