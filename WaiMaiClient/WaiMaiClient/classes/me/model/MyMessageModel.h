//
//  MyMessageModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMessageModel : NSObject

@property (nonatomic, strong) NSString *message_id;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *content_cn;
@property (nonatomic, strong) NSString *content_en;
@property (nonatomic, strong) NSString *title_cn;
@property (nonatomic, strong) NSString *title_en;
@property (nonatomic, strong) NSString *desc_cn;
@property (nonatomic, strong) NSString *desc_en;

@end
