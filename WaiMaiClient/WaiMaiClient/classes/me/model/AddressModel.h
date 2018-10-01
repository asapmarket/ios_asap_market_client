//
//  AddressModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *extm_name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSString *extm_phone;
@property (nonatomic, strong) NSString *is_default;
@property (nonatomic, strong) NSString *extm_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;


@end
