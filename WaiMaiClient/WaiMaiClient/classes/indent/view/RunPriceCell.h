//
//  RunPriceCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/26.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunOrderDetailModel.h"

@interface RunPriceCell : UITableViewCell

@property (nonatomic, strong) RunOrderDetailModel *detailModel;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, copy) void (^cancelButtonBlock)(RunOrderDetailModel *detailModel);
@property (nonatomic, copy) void (^paymentButtonBlock)(RunOrderDetailModel *detailModel);

@end
