//
//  RightGoodsCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodsTypeModel.h"

@class RightGoodsCell;

@protocol RightGoodsCellDelegate <NSObject>

- (void)onAddButtonClick:(FoodsListModel *)model typeModel:(FoodsTypeModel *)typeModel rightCell:(RightGoodsCell *)rightCell;

- (void)onMinusButonClicl:(FoodsListModel *)model typeModel:(FoodsTypeModel *)typeModel rightCell:(RightGoodsCell *)rightCell;

@end


@interface RightGoodsCell : UITableViewCell

@property (nonatomic, weak)id<RightGoodsCellDelegate>delegate;

@property (nonatomic, strong) FoodsListModel *foodsModel;

@property (nonatomic, strong) FoodsTypeModel *typeModel;

@property (nonatomic, strong) UILabel *countLabel;

@end
