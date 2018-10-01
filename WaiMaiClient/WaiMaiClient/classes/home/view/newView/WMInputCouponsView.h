//
//  WMInputCouponsView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/8/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMInputCouponsView : UIView

@property (nonatomic, copy) void (^cancelButtonClickBlock)(WMInputCouponsView *couponsView);

@property (nonatomic, copy) void (^verifyButtonClickBlock)(WMInputCouponsView *couponsView, UITextField *textField);

@property (nonatomic, copy) void (^endEditBlock)(WMInputCouponsView *couponsView, UITextField *textField);


@end
