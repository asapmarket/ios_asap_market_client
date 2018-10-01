//
//  CreateButton.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CreateButton.h"

@implementation CreateButton

+ (MultiParamButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title backCoclor:(UIColor *)backColor tittleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action{
    MultiParamButton *button = [MultiParamButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backColor];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title backCoclor:(UIColor *)backColor tittleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *button = [MultiParamButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backColor];
    [button setImage:image forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;

}

+ (UIButton *)initWithimage:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:4.0]; //设置矩圆角半径
    [button.layer setBorderWidth:0.5];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 33/255.0, 150/255.0, 233/255.0, 1 });
    [button.layer setBorderColor:colorref];//边框颜色
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;

}


+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:ButtonColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0]; //设置矩圆角半径
    [button.layer setBorderWidth:0.5];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 33/255.0, 150/255.0, 233/255.0, 1 });
    [button.layer setBorderColor:colorref];//边框颜色
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
