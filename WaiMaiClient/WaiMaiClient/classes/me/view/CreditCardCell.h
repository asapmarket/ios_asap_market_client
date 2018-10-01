//
//  CreditCardCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/9/19.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentModel.h"

@class CreditCardCell;

@protocol CreditCardCellDelegate <NSObject>

- (void)deleteButtonClick:(PaymentItem *)model;

@end

@interface CreditCardCell : UITableViewCell

@property (nonatomic, weak)id<CreditCardCellDelegate>delegate;

@property (nonatomic, strong) PaymentItem *model;

@end
