//
//  PaymentModel.h
//  WaiMaiClient
//
//  Created by 王 on 2018/5/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GBPaymentResponseFile  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Payment.data"]

@interface PaymentModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *userId;


+ (PaymentModel *)loadPaymentAccount;

+ (void)savePamentAccount:(PaymentModel *) model;

@end

@interface PaymentItem : NSObject

@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, strong) NSString *expTime;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *cvv;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *zipCode;


@end
