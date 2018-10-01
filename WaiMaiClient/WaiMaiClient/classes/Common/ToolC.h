//
//  ToolC.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

BOOL isDeviceIPhoneX(void);
void dispatchAsyncInMain(void(^block)(void));
void dispatchAsyncInGlobal(void(^block)(void));
void bdToMars(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon);
void marsToBD(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon);

