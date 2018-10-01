//
//  StoreListModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreModel.h"

@interface StoreListModel : NSObject

@property (nonatomic, strong) NSMutableArray *rows;

@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *total_page;

@end
