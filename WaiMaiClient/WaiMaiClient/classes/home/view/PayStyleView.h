//
//  PayStyleView.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayStyleView;

@protocol PayStyleViewDelegate <NSObject>

- (void)payStyleClickReturn:(NSString *)tyle;

@end

@interface PayStyleView : UIView

@property (nonatomic, weak) id<PayStyleViewDelegate>delegate;

@property (nonatomic, strong) NSString *payType;

@property (nonatomic, strong) NSString *rewardP;

@end
