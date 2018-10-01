//
//  SpecViewCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecClassListModel.h"

@class SpecViewCell;

@protocol SpecViewCellDelegate <NSObject>

- (void)specButtonClick:(SpecListModel *)model classModel:(SpecClassListModel *)classModel;

@end

@interface SpecViewCell : UITableViewCell

@property (nonatomic, weak) id<SpecViewCellDelegate>delegate;

@property (nonatomic, strong) SpecClassListModel *classModel;

@end
