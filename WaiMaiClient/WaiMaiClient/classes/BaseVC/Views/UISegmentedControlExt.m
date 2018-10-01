//
//  UISegmentedControlExt.m
//  Chason
//
//  Created by Chason on 16/8/22.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "UISegmentedControlExt.h"

@interface UISegmentedControlExt ()
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,strong)NSMutableArray *lines;
@end

@implementation UISegmentedControlExt

- (instancetype)initWithItems:(nullable NSArray *)items height:(CGFloat)height{
    self =[super initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];//49
    if (self) {
        _items=items;
        self.userInteractionEnabled=YES;
        self.font=[UIFont font16];
        self.normalColor=[UIColor blackColor];
        self.selectedColor=self.normalColor;
        self.normalBackgroundImage=[UIImage new];
        self.selectedBackgroundImage=[UIImage imageNamed:@"tabbar_img_case_pressed"];
        self.seperateLineColor = RGBHex(0xcccccc);
        self.seperateLineHidden = YES;
        self.seperateLineHeight = 15;
        self.backgroundColor=[UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (instancetype)initWithItems:(nullable NSArray *)items frame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        _items=items;
        self.userInteractionEnabled=YES;
        self.font=[UIFont font14];
        self.normalColor=[UIColor text6];
        self.selectedColor=self.normalColor;
        self.normalBackgroundImage=[UIImage new];
        self.selectedBackgroundImage=[UIImage imageNamed:@"OrderSelected"];
        self.seperateLineColor = RGBHex(0xcccccc);
        self.seperateLineHidden = YES;
        self.seperateLineHeight = 15;
        self.backgroundColor=[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)setFont:(UIFont *)font{
    _font=font;
    CGFloat space=0;
    NSString *mStr=[_items componentsJoinedByString:@""];
    CGSize size=[mStr sizeWithAttributes:@{NSFontAttributeName:self.font}];
    if (self.width>size.width) {
        space=(self.width-size.width)/(_items.count+1);
    }
    UIButton *tempButton;
    for (int i=0; i<_buttons.count; i++) {
        NSString *title=_items[i];
        UIButton *button=_buttons[i];
        CGSize size=[title sizeWithAttributes:@{NSFontAttributeName:self.font}];
        CGFloat width=size.width+space;
        button.size=CGSizeMake(width, self.height);
        if (tempButton==nil) {
            button.left=0;
        }
        else{
            button.left=tempButton.right;
        }
        tempButton=button;
    }
}

-(void)setNormalColor:(UIColor *)normalColor{
    _normalColor=normalColor;
    for (UIButton *button in _buttons) {
       [button setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor=selectedColor;
    for (UIButton *button in _buttons) {
       [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
    }
}

-(void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage{
    _normalBackgroundImage=normalBackgroundImage;
    for (UIButton *button in _buttons) {
        [button setBackgroundImage:self.normalBackgroundImage forState:UIControlStateNormal];
    }
}

-(void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    _selectedBackgroundImage=selectedBackgroundImage;
    for (UIButton *button in _buttons) {
       [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateSelected];
    }
}

- (void)setSeperateLineHeight:(float)seperateLineHeight {
    _seperateLineHeight = seperateLineHeight;
    for (UIView *line in _lines) {
        line.height = seperateLineHeight;
    }
}

- (void)setSeperateLineHidden:(BOOL)seperateLineHidden {
    _seperateLineHidden = seperateLineHidden;
    for (UIView *line in _lines) {
        line.hidden = seperateLineHidden;
    }
}

- (void)setSeperateLineColor:(UIColor *)seperateLineColor{
    _seperateLineColor = seperateLineColor;
    for (UIView *line in _lines) {
        line.backgroundColor = seperateLineColor;
    }
}

-(void)initView{
    _buttons=[[NSMutableArray alloc]init];
    _lines = [[NSMutableArray alloc] init];
    
    CGFloat space=0;
    NSString *mStr=[_items componentsJoinedByString:@""];
    
    CGSize size=[mStr sizeWithAttributes:@{NSFontAttributeName:self.font}];
    if (self.width>size.width) {
        space=(self.width-size.width)/(_items.count*2);
    }
    
    UIButton *tempButton;
    for (int i=0; i<_items.count; i++) {
        NSString *title=_items[i];
        CGSize size=[title sizeWithAttributes:@{NSFontAttributeName:self.font}];
        
        CGFloat width=size.width+space*2;
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectZero];
        button.imageView.contentMode=UIViewContentModeScaleToFill;
        button.tag=100+i;
        button.titleLabel.font=self.font;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:self.normalColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.normalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.selectedBackgroundImage forState:UIControlStateSelected];
        button.size=CGSizeMake(width, self.height);
        if (tempButton==nil) {
            button.leftTop=CGPointMake(0, 0);
        }
        else{
            button.leftTop=CGPointMake(tempButton.right+0.5,0);
        }
        [self addSubview:button];
        
        [button onClick:^(id sender) {
            UIButton *selectedButton=(UIButton *)sender;
            for (UIButton *button in _buttons) {
                if (button.selected&&selectedButton.tag==button.tag) {
                    return ;
                }
                else{
                    button.selected=NO;
                }
            }
            selectedButton.selected=YES;
            if (self.valueChange) {
                self.valueChange(i);
            }
        }];
        
        tempButton=button;
        [_buttons addObject:button];
        
        UILine *seperateLine = [[UILine alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.seperateLineHeight)];
        seperateLine.backgroundColor = self.seperateLineColor;
        seperateLine.hidden = self.seperateLineHidden;
        seperateLine.leftCenter = CGPointMake(button.right, button.center.y);
        [self addSubview:seperateLine];
        [_lines addObject:seperateLine];
    }
}

-(int)selectedIndex{
    int selectedIndex=0;
    for (int i=0; i<_buttons.count; i++) {
        UIButton *button=_buttons[i];
        if (button.selected) {
            selectedIndex=i;
        }
    }
    return selectedIndex;
}

-(void)setSelectedIndex:(int)selectedIndex{
    for (UIButton *button in _buttons) {
        button.selected=NO;
    }
    UIButton *button=_buttons[selectedIndex];
    button.selected=YES;
}

@end
