//
//  ExchangeView.h
//  WaiMaiClient
//
//  Created by 王 on 2017/12/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletModel.h"

@class ExchangeView;

@protocol ExchangeViewDelegate <NSObject>

- (void)exchangeButtonDidClick:(WalletModel *)model;

@end

@interface ExchangeView : UIView

@property (nonatomic, weak)id<ExchangeViewDelegate>delegate;

@property (nonatomic, strong) WalletModel *model;


@end
