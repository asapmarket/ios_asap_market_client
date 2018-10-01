//
//  RunOrderParam.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/15.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunOrderParam : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *page_size;
@property (nonatomic, strong) NSString *state;

@end
