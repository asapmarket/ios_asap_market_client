//
//  CreditCardTextView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/1/12.
//  Copyright © 2018年 王. All rights reserved.
//

#import "CreditCardTextView.h"

@interface CreditCardTextView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation CreditCardTextView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 34)];
    _descLabel.textAlignment = NSTextAlignmentLeft;
    _descLabel.font = [UIFont systemFontOfSize:14];
    _descLabel.textColor = [UIColor blackColor];
    [self addSubview:_descLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, SCREEN_WIDTH-150, 34)];
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    _textField.textColor = [UIColor blackColor];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 34, SCREEN_WIDTH-40, 1)];
    line.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:line];
}

- (void)setDescStr:(NSString *)descStr{
    _descLabel.text = descStr;
}

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldReturn:textView:)]) {
        [self.delegate textFieldReturn:textField textView:self];
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
