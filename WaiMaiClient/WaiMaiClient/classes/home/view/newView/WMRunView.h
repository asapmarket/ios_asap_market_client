//
//  WMRunView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/8/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMRunView : UIView

@property (nonatomic, copy) void (^runViewDidTouchBlock)(WMRunView *runView);

@end
