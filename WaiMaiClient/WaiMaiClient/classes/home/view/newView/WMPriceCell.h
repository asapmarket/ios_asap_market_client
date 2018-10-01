//
//  WMPriceCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/8/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmoutModel.h"
#import "RunUserPointParam.h"

@interface WMPriceCell : UITableViewCell

@property (nonatomic, strong) AmoutModel *model;

@property (nonatomic, strong) WMUserCouponsModel *couponsModel;

@end
