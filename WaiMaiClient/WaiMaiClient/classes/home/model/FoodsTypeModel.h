//
//  FoodsTypeModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodsListModel.h"

@interface FoodsTypeModel : QKCoding

@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *type_name_cn;
@property (nonatomic, strong) NSString *type_name_en;

@property (nonatomic, strong) NSMutableArray *foods_list;

+ (FoodsTypeModel *)initFoodsTypeModel:(FoodsTypeModel *)typeModel listModel:(FoodsListModel *)listModel;
@end
