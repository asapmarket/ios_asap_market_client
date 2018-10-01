//
//  Const.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//
#define isIOS7_9 ([[UIDevice currentDevice].systemVersion doubleValue] < 9.0)

#define isIOS8_9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
#define isIOS8_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
#define isIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

#define isIPhoneX [NSString isDeviceIPhoneX]
#define IPhoneTopOffset ([NSString isDeviceIPhoneX]?88:0)
#define IPhoneBottomOffset ([NSString isDeviceIPhoneX]?34:0)

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
#define AutoFit(a)    (a)*(kScreenWidth/375.0)

#define TopBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

#define StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

#define NewsButtonBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?20:0)

#define ButomBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define gSCREEN_MAX_LENGTH (MAX(kScreenWidth, kScreenWidth))
#define gSCREEN_MIN_LENGTH (MIN(kScreenWidth, kScreenWidth))

#define IS_IPHONE_4 (gSCREEN_MAX_LENGTH == 480.0)
#define IS_IPHONE_5 (gSCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (gSCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (gSCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X ([[UIScreen mainScreen] currentMode].size.height == 2436)

#define WeakSelf __weak __typeof(self)weakSelf = self;
#define StrongSelf __strong __typeof(&*weakSelf)self = weakSelf;
#define WeakObj(o) __weak typeof(o) o##Weak = o;

#define kNotificationUserChange @"kNotificationUserChange"
#define kNotificationReachability @"kNotificationReachability"

#define kResultErrorDomin           @"code"
#define kResultErrorDesKey          @"message"

//验证码时间
#define SendNextVerifyCode (60)

#define GuidePageVersion    @"1.0.0"  //引导页版本号，每次更新引导页时需要修改该值
#define GuidePageVersionKey    @"GuidePageVersionKey"  //引导页版本号，每次更新引导页时需要修改该值

#ifdef DEBUG //调试阶段
#define NSLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define NSLog(...)
#endif

