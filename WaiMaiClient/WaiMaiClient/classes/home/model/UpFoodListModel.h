//
//  UpFoodListModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpFoodListModel : NSObject

@property (nonatomic, strong) NSString *foods_id;
@property (nonatomic, strong) NSString *spec_id_list;
@property (nonatomic, assign) int quantity;
@property (nonatomic, strong) NSString *price;

@end
