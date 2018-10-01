//
//  OrderStoreListCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailStoreModel.h"

@interface OrderStoreListCell : UITableViewCell

@property (nonatomic, strong) OrderDetailStoreModel *storeModel;

+ (CGFloat)cellHeightWithModel:(OrderDetailStoreModel *)model;

@end
