//
//  PaymentModel.m
//  WaiMaiClient
//
//  Created by 王 on 2018/5/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import "PaymentModel.h"

@implementation PaymentModel
MJCodingImplementation


- (NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark 存储信用卡信息
+ (void)savePamentAccount:(PaymentModel *) model{
    
    [NSKeyedArchiver archiveRootObject:model toFile:GBPaymentResponseFile];
}


#pragma mark 读取信用卡信息
+ (PaymentModel *)loadPaymentAccount{
    PaymentModel *model=[NSKeyedUnarchiver unarchiveObjectWithFile:GBPaymentResponseFile];
    return  model;
}
@end

@implementation PaymentItem
MJCodingImplementation
@end
