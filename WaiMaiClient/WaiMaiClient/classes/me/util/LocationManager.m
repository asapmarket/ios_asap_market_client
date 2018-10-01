//
//  LocationManager.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LocationManager.h"


@implementation LocationManager

+ (LocationManager *)shareManager{
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (nil == manager) {
            manager = [[LocationManager alloc] init];
        }
    });
    return manager;
}

- (void)setLocationArray:(NSMutableArray *)locationArray{
    _locationArray = locationArray;
}



@end
