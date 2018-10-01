//
//  SelAddressCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface SelAddressCell : UITableViewCell

@property (nonatomic, strong) AddressModel *model;
@property (nonatomic, strong) UIView *line;

@end
