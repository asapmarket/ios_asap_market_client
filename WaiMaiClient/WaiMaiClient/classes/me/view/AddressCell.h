//
//  AddressCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@protocol AddressCellDelegate <NSObject>

- (void)editButtonClick:(AddressModel *)model;

@end

@interface AddressCell : UITableViewCell

@property (nonatomic, weak)id<AddressCellDelegate>delegate;
@property (nonatomic, strong) AddressModel *model;

- (void)setDefaultAddressWithStatus:(NSString *)status;

@end
