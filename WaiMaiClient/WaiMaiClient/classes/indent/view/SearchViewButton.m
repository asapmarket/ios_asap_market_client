//
//  SearchViewButton.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SearchViewButton.h"

@implementation SearchViewButton


+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.selected = NO;
    button.titleLabel.numberOfLines = 0;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0]; //设置矩圆角半径
    [button.layer setBorderWidth:0.5];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 33/255.0, 150/255.0, 233/255.0, 1 });
    [button.layer setBorderColor:colorref];//边框颜色
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor hexStringToColor:@"#333333"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(20, 5, 20, 30);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
