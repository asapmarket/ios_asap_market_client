//
//  CalculatePrice.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/9.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyShopCartBaseModel.h"

@interface CalculatePrice : NSObject

+ (float)getPriceWithDataArray:(NSMutableArray *)dataArray;

+ (MyShopCartBaseModel *)updateMyShopCartBaseModel:(MyShopCartBaseModel *)baseModel;

@end
