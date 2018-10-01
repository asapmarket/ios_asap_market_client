//
//  LocationManager.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+ (LocationManager *)shareManager;

@property (nonatomic, strong) NSMutableArray *locationArray;


@end
