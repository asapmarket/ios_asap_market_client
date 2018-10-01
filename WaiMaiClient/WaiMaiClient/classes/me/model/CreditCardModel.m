//
//  CreditCardModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/9/19.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CreditCardModel.h"

@implementation CreditCardModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"cardId":@"id",
             };
}

@end
