//
//  LoginManager.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LoginManager.h"
#import "LoginViewController.h"

@implementation LoginManager

+ (void)toLogin{
    LoginViewController *loginCtrl = [[LoginViewController alloc] init];
    UINavigationControllerExt *loginNav = [[UINavigationControllerExt alloc] initWithRootViewController:loginCtrl];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
}

@end
