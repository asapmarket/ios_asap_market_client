//
//  CreditCardParam.h
//  WaiMaiClient
//
//  Created by 王 on 2017/9/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditCardParam : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *stripe_token;
@property (nonatomic, strong) NSString *order_type;


@end
