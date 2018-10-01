//
//  OrderParam.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderUpBaseModel.h"
#import "MyShopCartBaseModel.h"

@interface OrderParam : NSObject

+ (OrderUpBaseModel *)getOrderParamWithCartBaseModel:(MyShopCartBaseModel *)cartBaseModel patType:(NSString *)payType remark:(NSString *)remark ectmId:(NSString *)extmId distribution_time:(NSString *)distribution_time;

@end
