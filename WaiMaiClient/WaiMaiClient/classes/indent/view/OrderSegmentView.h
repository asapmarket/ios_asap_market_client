//
//  OrderSegmentView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/15.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSegmentView : UIView

@property (nonatomic, copy) void (^oderButtonBlock)(UIButton *button);
@property (nonatomic, copy) void (^runButtonBlock)(UIButton *button);

@end
