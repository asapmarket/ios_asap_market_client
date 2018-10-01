//
//  CourierLocationCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailBaseModel.h"
#import "RunOrderDetailModel.h"

@interface CourierLocationCell : UITableViewCell

@property (nonatomic, strong) OrderDetailBaseModel *baseModel;
@property (nonatomic, strong) RunOrderDetailModel *runModel;

@end
