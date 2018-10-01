//
//  AppDefine.h
//  whcy
//
//  Created by 王 on 2018/3/23.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *gDeviceID; //设置的唯一号
extern NSString *gUserID; //用户ID
extern NSString *gToken; //本次上线的token
extern NSString *gServerAppname;//应用的标志符
extern NSString *gDeviceType; //机型
extern NSString *gDeviceModel; //JIXING
extern NSString *gScreenDisplay; //屏幕参数
extern NSString *gScreenPixel; //屏幕参数
extern NSString *gOSVersion; //操作系统版本号
extern NSString *gIOSVersion; //操作系统版本号
extern NSString *gNetWorkName; //网络类型
extern NSString *gRegisterType; //注册类型

extern NSString *gInstallVersion;//客户端版本号,从pInfo.list中读取

extern AFNetworkReachabilityStatus gNetworkStatus; //网络状态

extern CGFloat   EXLongitude;
extern CGFloat   EXLatitude;

@interface AppDefine : NSObject

@end
