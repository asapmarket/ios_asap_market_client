//
//  WMInputCouponsView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMInputCouponsView.h"

@interface WMInputCouponsView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *couponsView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation WMInputCouponsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
        [self addGestureRecognizer:tap];
        
        _couponsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-175, self.width, 175)];
        _couponsView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_couponsView];
        
        _cancleButton = [CreateButton creatButtonWithFrame:CGRectMake(0, 0, 70, 54) title:NSLocalizedString(@"cancel", nil) backCoclor:[UIColor whiteColor] tittleColor:[UIColor hexStringToColor:@"666666"] font:[UIFont font13] target:self action:@selector(cancleButtonClick:)];
        [_couponsView addSubview:_cancleButton];
        
        _verifyButton = [CreateButton creatButtonWithFrame:CGRectMake(self.width-70, 0, 70, 54) title:NSLocalizedString(@"verify", nil) backCoclor:[UIColor whiteColor] tittleColor:[UIColor hexStringToColor:@"666666"] font:[UIFont font13] target:self action:@selector(verifyButtonClick:)];
        [_couponsView addSubview:_verifyButton];
        
        _titleLabel = [CYLabel initLabelWithFrame:CGRectMake(80, 0, self.width-160, 54) text:NSLocalizedString(@"Coupons", nil) textAlignment:NSTextAlignmentCenter font:[UIFont font15] textColor:RGB(51, 51, 51)];
        [_couponsView addSubview:_titleLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 54, self.width, 1)];
        _line.backgroundColor = [UIColor hexStringToColor:@"#c2c2c2"];
        [_couponsView addSubview:_line];
        
        _descLabel = [CYLabel initLabelWithFrame:CGRectMake(10, 65, self.width-20, 34) text:NSLocalizedString(@"EnterCoupons", nil) textAlignment:NSTextAlignmentCenter font:[UIFont font14] textColor:RGB(51, 51, 51)];
        [_couponsView addSubview:_descLabel];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 110, self.width-30, 44)];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textColor = ButtonColor;
        [_textField setFont:[UIFont font14]];
        _textField.returnKeyType = UIReturnKeySend;
        [_couponsView addSubview:_textField];
        
    }
    return self;
}

- (void)onTap{
    
    if (self.cancelButtonClickBlock){
        self.cancelButtonClickBlock(self);
    }
    [_textField endEditing:YES];
}

- (void)cancleButtonClick:(UIButton *)btn{
    if (self.cancelButtonClickBlock){
        self.cancelButtonClickBlock(self);
    }
}

- (void)verifyButtonClick:(UIButton *)btn{
    [_textField endEditing:YES];
    if (self.verifyButtonClickBlock){
        self.verifyButtonClickBlock(self, _textField);
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField endEditing:YES];
    if (self.endEditBlock) {
        self.endEditBlock(self, textField);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
