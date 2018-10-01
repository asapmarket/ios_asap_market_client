//
//  UserInfoTool.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserInfoTool : NSObject

+ (void)saveLoginAccount:(UserInfo *) model;

+ (UserInfo *)loadLoginAccount;

@end
