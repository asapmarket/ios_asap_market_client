//
//  MessageBaseModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/22.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MessageBaseModel.h"

@implementation MessageBaseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rows":[MyMessageModel class]};
}

@end
