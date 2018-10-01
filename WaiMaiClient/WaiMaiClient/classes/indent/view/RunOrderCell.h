//
//  RunOrderCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunOrderModel.h"


@class RunOrderCell;

@protocol RunOrderCellDelegate <NSObject>

- (void)runOrderDetailButtonClickWithModel:(RunOrderItem *)model;

@end
@interface RunOrderCell : UITableViewCell

@property (nonatomic, weak)id<RunOrderCellDelegate>delegate;

@property (nonatomic, strong) RunOrderItem *item;

+ (CGFloat)cellHeightWithModel:(RunOrderItem *)item;

@end
