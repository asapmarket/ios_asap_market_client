//
//  UIBarButtonItem+MJ.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UIBarButtonItem+MJ.h"

@implementation UIBarButtonItem (MJ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                         highIcon:(NSString *)highIcon
                           target:(id)target
                           action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateHighlighted];
    
    button.frame = CGRectMake(0, 0, 68, 44);
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(14.725, 0, 14.725, 50)];
    
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon
                         highIcon:(NSString *)highIcon
                           target:(id)target
                           action:(SEL)action
                             size:(CGSize)size
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:(UIControlStateHighlighted)];
    
    button.frame = (CGRect){CGPointZero, size.width, size.height};
    
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font size:(CGSize)size
                           target:(id)target
                           action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.frame = (CGRect){CGPointZero, size.width, size.height};
    
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



@end
