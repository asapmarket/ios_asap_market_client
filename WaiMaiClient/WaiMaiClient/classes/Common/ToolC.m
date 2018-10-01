//
//  ToolC.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "ToolC.h"

BOOL isDeviceIPhoneX(){
    NSString *platform = [NSString deviceString];
    if ([platform isEqualToString:@"iPhone Simulator"]) {
        // 模拟器下采用屏幕的高度来判断
        return [UIScreen mainScreen].bounds.size.height == 812;
    }
    // iPhone10,6是美版iPhoneX
    return [platform isEqualToString:@"iPhone X"];;
}

void dispatchAsyncInMain(void(^block)(void)){
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

void dispatchAsyncInGlobal(void(^block)(void)){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        block();
        
    });
}

const double x_pi = M_PI * 3000.0 / 180.0;
void bdToMars(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon){
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}

void marsToBD(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon){
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}

