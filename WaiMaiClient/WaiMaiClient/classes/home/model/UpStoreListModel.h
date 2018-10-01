//
//  UpStoreListModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpFoodListModel.h"

@interface UpStoreListModel : NSObject

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSMutableArray *foods_list;

@end
