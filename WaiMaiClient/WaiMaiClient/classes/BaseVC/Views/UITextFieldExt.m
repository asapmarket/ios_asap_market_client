//
//  UITextFieldExt.m
//  PolicePatrol
//
//  Created by chason on 2017/12/6.
//  Copyright © 2017年 Government. All rights reserved.
//

#import "UITextFieldExt.h"

@interface UITextFieldExt ()
@property(nonatomic,strong)UIButton *clearButton;
@end

@implementation UITextFieldExt

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
        self.rightView=[[UIView alloc]initWithFrame:CGRectZero];
        self.rightViewMode=UITextFieldViewModeAlways;
    }
    return self;
}

-(void)setRightView:(UIView *)view{
    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, view.width+32, self.height)];
    _clearButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [_clearButton setImage:[UIImage imageNamed:@"delete_icon_search_default"] forState:UIControlStateNormal];
    _clearButton.hidden=YES;
    _clearButton.backgroundColor=[UIColor clearColor];
    [_clearButton onClick:^(id sender) {
        self.text=@"";
        self->_clearButton.hidden=YES;
    }];
    _clearButton.leftCenter=CGPointMake(0, rightView.height/2);
    [rightView addSubview:view];
    view.leftCenter=CGPointMake(_clearButton.right, rightView.height/2);
    [rightView addSubview:_clearButton];
    [super setRightView:rightView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
        self.rightView=[[UIView alloc]initWithFrame:CGRectZero];
        self.rightViewMode=UITextFieldViewModeAlways;
    }
    return self;
}

- (void)textFieldDidChange:(UITextField *)sender{
    if (sender.text.length>0) {
        _clearButton.hidden=NO;
    }
    else{
        _clearButton.hidden=YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)sender{
    if (sender.text.length>0) {
        _clearButton.hidden=NO;
    }
    else{
        _clearButton.hidden=YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)sender{
    _clearButton.hidden=YES;
}

@end
