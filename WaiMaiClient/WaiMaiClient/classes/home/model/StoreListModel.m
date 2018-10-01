//
//  StoreListModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StoreListModel.h"

@implementation StoreListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[StoreModel class],
             };
}
@end
