//
//  RunOrderStateView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/4/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunOrderStateView : UIView

@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *exp_name;
@property (nonatomic, assign) NSInteger payment; //0:未付款 1：已付款
@property (nonatomic, assign) NSInteger paymentType; //支付方式

@end
