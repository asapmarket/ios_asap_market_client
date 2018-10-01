//
//  BalanceView.h
//  WaiMaiClient
//
//  Created by 王 on 2017/12/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletModel.h"
@class BalanceView;

@protocol BalanceViewDelegate <NSObject>

- (void)rewardPointDidClick:(WalletModel *)model;

@end

@interface BalanceView : UIView

@property (nonatomic, weak)id<BalanceViewDelegate>delegate;

@property (nonatomic, strong) WalletModel *model;

@end
