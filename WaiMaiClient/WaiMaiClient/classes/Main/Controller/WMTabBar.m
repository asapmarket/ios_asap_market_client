//
//  WMTabBar.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMTabBar.h"
#import "UIButton+Edge.h"
#import "YPTabItem.h"
#import "ShopCartManager.h"

@interface WMTabBar()

@property (nonatomic, strong) YPTabItem *middleBtn;
@property (nonatomic, strong) YPTabItem *cartBtn;

@end

@implementation WMTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.cartBtn setImagePositionWithType:SSImagePositionTypeTop spacing:4];
    // 其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++)
    {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class])
        {
            view.width = self.width / 5.0;
            view.x = self.width * j / 5.0;
            j++;
            if (j == 2)
            {
                j++;
            }
        }
    }
    [self addSubview:_cartBtn];

}
// 发布
- (void)didClickPublishBtn:(UIButton*)sender {
    if (self.didMiddBtn) {
        self.didMiddBtn();
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden == NO)
    {
        CGPoint newP = [self convertPoint:point toView:self.middleBtn];
        if ( [self.middleBtn pointInside:newP withEvent:event])
        {
            return self.middleBtn;
        }else
        {
            return [super hitTest:point withEvent:event];
        }
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}

- (UIButton *)cartBtn{
    if (!_cartBtn) {
        _cartBtn = [[YPTabItem alloc] init];
        [_cartBtn setImage:[UIImage imageNamed:@"shopCart_click"] forState:UIControlStateNormal];
        [_cartBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cartBtn.adjustsImageWhenHighlighted = NO;
        _cartBtn.size = CGSizeMake(114, 97);
        _cartBtn.centerX = self.width / 2;
        _cartBtn.centerY = 0;
        _cartBtn.badgeStyle = YPTabItemBadgeStyleNumber;
        _cartBtn.badgeBackgroundColor = [UIColor hexStringToColor:@"#f12c20"];
        _cartBtn.badgeTitleFont = [UIFont font13];
        _cartBtn.badgeTitleColor = [UIColor whiteColor];
        [_cartBtn setNumberBadgeMarginTop:15 centerMarginRight:10 titleHorizonalSpace:3 titleVerticalSpace:3];
        self.middleBtn = _cartBtn;
        [ShopCartManager shareManager].tabBar = _cartBtn;
    }
    return _cartBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
