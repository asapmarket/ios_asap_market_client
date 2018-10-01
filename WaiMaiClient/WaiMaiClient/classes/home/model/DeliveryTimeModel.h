//
//  DeliveryTimeModel.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliveryTimeModel : NSObject

@property (nonatomic, strong) NSMutableArray *rows;

@end

@interface DeliveryTimeItem : NSObject

@property (nonatomic, strong) NSString *distribution_time;

@end
