//
//  RunOrderStateParam.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/26.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderStateParam.h"

@implementation RunOrderStateParam

- (NSString *)token{
    return [UrlsManager token];
}

- (NSString *)user_id{
    return [UrlsManager userID];
}

@end
