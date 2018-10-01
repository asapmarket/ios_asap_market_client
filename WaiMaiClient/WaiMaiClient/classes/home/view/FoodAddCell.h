//
//  FoodAddCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodsDetailBaseModel.h"

@class FoodAddCell;

@protocol FoodAddCellDelegate <NSObject>

- (void)onAddButtonClick:(FoodsDetailBaseModel *)model;

- (void)onMinusButonClicl:(FoodsDetailBaseModel *)model;

@end

@interface FoodAddCell : UITableViewCell

@property (nonatomic, weak)id<FoodAddCellDelegate>delegate;

@property (nonatomic, strong) FoodsDetailBaseModel *foodsModel;

@end
