//
//  AddressListModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import "AddressListModel.h"

@implementation AddressListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"address_list":[AddressModel class]};
}

@end
