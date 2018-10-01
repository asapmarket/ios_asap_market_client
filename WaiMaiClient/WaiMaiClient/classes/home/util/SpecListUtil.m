//
//  SpecListUtil.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SpecListUtil.h"

@implementation SpecListUtil

+ (SpecIDBaseModel *)getSpecWithFoodListModel:(FoodsListModel *)model classModel:(SpecClassListModel *)classModel listModel:(SpecListModel *)listModel specIdModel:(SpecIDBaseModel *)id_base_model{

    if (id_base_model == nil) {
        id_base_model = [SpecListUtil getDefaultSpecClassIDModel:model];
    }
    
    for (SpecClassIDModel *class_id_model in id_base_model.specClassID_list) {
        if ([classModel.spec_class_id isEqualToString:class_id_model.spec_class_id]) {
            class_id_model.spec_id = listModel.spec_id;
            class_id_model.spec_name_cn = listModel.spec_name_cn;
            class_id_model.spec_name_en = listModel.spec_name_en;
            continue;
        }
    }
    
        
    return id_base_model;
}

+ (NSString *)getSpecWithIDBaseModel:(SpecIDBaseModel *)model{
    if (model.specClassID_list.count == 0){
        return nil;
    }
    NSString *string = nil;
    NSMutableArray *idArray = [NSMutableArray array];
    for (SpecClassIDModel *id_model in model.specClassID_list) {
        if ([SpecListUtil deptNumInputShouldNumber:id_model.spec_id]) {
            [idArray addObject:id_model.spec_id];
        }
        if (string == nil) {
            string = id_model.spec_id;
        }else{
            string = [NSString stringWithFormat:@"%@,%@",string, id_model.spec_id];
        }
    }
    if (idArray.count == 0) {
        return string;
    }else if (idArray.count == 1){
        string = idArray[0];
    }else{
        string = [SpecListUtil arraySortASCWithArray:idArray];
    }
    return string;
}

+ (NSString *)arraySortASCWithArray:(NSMutableArray *)array{
    
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    
    NSLog(@"result=%@",result);
    NSString *string = nil;
    for (NSString *str in result) {
        if (string == nil) {
            string = str;
        }else{
            string = [NSString stringWithFormat:@"%@,%@",string, str];
        }
    }
    
    return string;
    
}


+ (BOOL) deptNumInputShouldNumber:(NSString *)str {
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

+ (NSString *)getSpecNameENWithIDBaseModel:(SpecIDBaseModel *)model{
    NSString *string = nil;
    for (SpecClassIDModel *id_model in model.specClassID_list) {
        if (string == nil) {
            string = id_model.spec_name_en;
        }else{
            string = [NSString stringWithFormat:@"%@_%@",string, id_model.spec_name_en];
        }
    }
    return string;
}

+ (NSString *)getSpecNameCNWithIDBaseModel:(SpecIDBaseModel *)model{
    NSString *string = nil;
    for (SpecClassIDModel *id_model in model.specClassID_list) {
        if (string == nil) {
            string = id_model.spec_name_cn;
        }else{
            string = [NSString stringWithFormat:@"%@_%@",string, id_model.spec_name_cn];
        }
    }
    return string;
}

+ (SpecIDBaseModel *)getDefaultSpecClassIDModel:(FoodsListModel *)model{
    SpecIDBaseModel *classModel = [[SpecIDBaseModel alloc] init];
    
    for (SpecClassListModel *spec_c_model in model.spec_class_list){
        SpecClassIDModel *class_id_Model = [[SpecClassIDModel alloc] init];
        class_id_Model.spec_class_id = spec_c_model.spec_class_id;
        SpecListModel *listModel = spec_c_model.spec_list[0];
        class_id_Model.spec_id = listModel.spec_id;
        class_id_Model.spec_name_cn = listModel.spec_name_cn;
        class_id_Model.spec_name_en = listModel.spec_name_en;
        [classModel.specClassID_list addObject:class_id_Model];
    }
    return classModel;
}

+ (int)stringComparison:(NSString *)specAllID{
    ShopCartBaseModel *baseModel = [[ShopCartManager shareManager] loadShopCartBaseModel];
    if (baseModel.dataArray.count == 0) {
        return 0;
    }
    for (ShopCartModel *cartModel in baseModel.dataArray) {
        if ([cartModel.specAllId isEqualToString:specAllID]) {
            return cartModel.specCount;
        }
    }
    return 0;
}

@end
