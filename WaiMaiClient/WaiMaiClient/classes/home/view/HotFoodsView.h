//
//  HotFoodsView.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotFoodsModel.h"

@class HotFoodsView;

@protocol HotFoodsViewDelegate <NSObject>

- (void)foodViewDidClick:(HotFoodsModel *)model;

@end

@interface HotFoodsView : UIView

@property (nonatomic, weak) id<HotFoodsViewDelegate>delegate;

@property (nonatomic, strong) NSArray *hotFoodArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@end
