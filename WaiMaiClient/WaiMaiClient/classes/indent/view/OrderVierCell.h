//
//  OrderVierCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderListModel.h"

@class OrderVierCell;

@protocol OrderVierCellDelegate <NSObject>

- (void)detailButtonClickWithModel:(OrderListModel *)model;

@end

@interface OrderVierCell : UITableViewCell

@property (nonatomic, weak)id<OrderVierCellDelegate>delegate;

@property (nonatomic, strong) OrderListModel *model;


+ (CGFloat) cellHeightWithModel:(OrderListModel *)model;
@end
