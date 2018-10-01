//
//  MessageBaseModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/22.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyMessageModel.h"


@interface MessageBaseModel : NSObject

@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *total_page;

@end
