//
//  RunOrderGoodsDetailCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunOrderDetailModel.h"

@interface RunOrderGoodsDetailCell : UITableViewCell

@property (nonatomic, strong) RunOrderDetailModel *detailModel;

@property (nonatomic, strong) UILabel *promptLabel;

@property (nonatomic, copy) void (^imageViewDidTouchBlock)(RunOrderDetailModel *detailModel);

@end
