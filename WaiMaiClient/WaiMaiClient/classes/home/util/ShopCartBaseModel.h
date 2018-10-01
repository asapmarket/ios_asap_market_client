//
//  ShopCartBaseModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartModel.h"

@interface ShopCartBaseModel : QKCoding

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
