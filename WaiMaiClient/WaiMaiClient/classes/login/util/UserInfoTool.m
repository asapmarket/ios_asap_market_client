//
//  UserInfoTool.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UserInfoTool.h"

#define GBLoginResponseFile  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"loginReponse.data"]

@implementation UserInfoTool

#pragma mark 存储登录用户信息
+ (void)saveLoginAccount:(UserInfo *) model{
    
    [NSKeyedArchiver archiveRootObject:model toFile:GBLoginResponseFile];
}


#pragma mark 读取登录用户信息
+ (UserInfo *)loadLoginAccount{
    UserInfo *model=[NSKeyedUnarchiver unarchiveObjectWithFile:GBLoginResponseFile];
    return  model;
}

@end
