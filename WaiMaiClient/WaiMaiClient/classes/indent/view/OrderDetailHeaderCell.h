//
//  OrderDetailHeaderCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailBaseModel.h"
#import "RunOrderDetailModel.h"

@interface OrderDetailHeaderCell : UITableViewCell

@property (nonatomic, strong) OrderDetailBaseModel *baseModel;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) RunOrderDetailModel *runModel;

@end
