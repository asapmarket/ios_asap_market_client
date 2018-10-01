//
//  StoreGoodsBaseModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodsTypeModel.h"

@interface StoreGoodsBaseModel : QKCoding

@property (nonatomic, strong) NSMutableArray *type_list;

@end
