//
//  PayStyleView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "PayStyleView.h"
#import "StringColor.h"

@interface PayStyleView ()

@property (nonatomic, strong) UIButton *payPalBtn;
@property (nonatomic, strong) UIButton *rewardPoint;
@property (nonatomic, strong) UIButton *applePayBtn;
@property (nonatomic, strong) UIButton *creditCard;
@property (nonatomic, strong) UIButton *cashBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *rpLabel;

@end

@implementation PayStyleView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, (self.bounds.size.height-160)/2-64, SCREEN_WIDTH-20, 165)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _bgView.layer.cornerRadius = 5;
        
        UILabel *titleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
        titleLabel.frame = CGRectMake(10, 18, _bgView.bounds.size.width-20, 19);
        titleLabel.text = NSLocalizedString(kSelectPayStyle, nil);
        [_bgView addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, _bgView.bounds.size.width, 0.5)];
        line.backgroundColor = [UIColor hexStringToColor:@"#e9e9e9"];
        [_bgView addSubview:line];
        
        _payPalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payPalBtn.frame = CGRectMake(20, 60, 57, 80);
        _payPalBtn.backgroundColor = [UIColor whiteColor];
        [_payPalBtn setTitle:@"paypal" forState:UIControlStateNormal];
        [_payPalBtn setImage:[UIImage imageNamed:@"paypal"] forState:UIControlStateNormal];
        [_payPalBtn setImage:[UIImage imageNamed:@"paypal_select"] forState:UIControlStateSelected];
        _payPalBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_payPalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_payPalBtn setTitleColor:ButtonColor forState:UIControlStateSelected];
        [_payPalBtn verticalImageAndTitle:5];
        [_payPalBtn addTarget:self action:@selector(payPalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_payPalBtn];
        
        
        _creditCard = [UIButton buttonWithType:UIButtonTypeCustom];
        _creditCard.frame = CGRectMake((_bgView.bounds.size.width-57*4-40)/4.0+77, 60, 57, 80);
        _creditCard.backgroundColor = [UIColor whiteColor];
        [_creditCard setTitle:NSLocalizedString(kPayWithCard, nil) forState:UIControlStateNormal];
        [_creditCard setImage:[UIImage imageNamed:@"payCard"] forState:UIControlStateNormal];
        [_creditCard setImage:[UIImage imageNamed:@"payCard_select"] forState:UIControlStateSelected];
        _creditCard.titleLabel.font = [UIFont systemFontOfSize:12];
        [_creditCard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_creditCard setTitleColor:ButtonColor forState:UIControlStateSelected];
        [_creditCard verticalImageAndTitle:5];
        [_creditCard addTarget:self action:@selector(creditCardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_creditCard];
        
        _cashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cashBtn.frame = CGRectMake(2*(_bgView.bounds.size.width-57*4-40)/4.0+20+57*2, 60, 57, 80);
        _cashBtn.backgroundColor = [UIColor whiteColor];
        [_cashBtn setTitle:NSLocalizedString(kCashPayments, nil) forState:UIControlStateNormal];
        [_cashBtn setImage:[UIImage imageNamed:@"CashPayments"] forState:UIControlStateNormal];
        [_cashBtn setImage:[UIImage imageNamed:@"CashPayments_select"] forState:UIControlStateSelected];
        _cashBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cashBtn setTitleColor:ButtonColor forState:UIControlStateSelected];
        [_cashBtn verticalImageAndTitle:5];
        [_cashBtn addTarget:self action:@selector(cashBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_cashBtn];
        
        _rewardPoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _rewardPoint.frame = CGRectMake(3*(_bgView.bounds.size.width-57*4-40)/4.0+20+57*3, 60, 57, 80);
        _rewardPoint.backgroundColor = [UIColor whiteColor];
        [_rewardPoint setTitle:NSLocalizedString(kRewardPointPay, nil) forState:UIControlStateNormal];
        [_rewardPoint setImage:[UIImage imageNamed:@"rewardPoint"] forState:UIControlStateNormal];
        [_rewardPoint setImage:[UIImage imageNamed:@"rewardPoint_select"] forState:UIControlStateSelected];
        _rewardPoint.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rewardPoint setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rewardPoint setTitleColor:ButtonColor forState:UIControlStateSelected];
        [_rewardPoint verticalImageAndTitle:5];
        [_rewardPoint addTarget:self action:@selector(rewardPointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_rewardPoint];
        
        _rpLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:9] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentCenter];
        _rpLabel.frame = CGRectMake(3*(_bgView.bounds.size.width-57*4-40)/4.0-20+57*3, 145, 85, 12);
        [_bgView addSubview:_rpLabel];
        
        
//
//        _applePayBtn = [CreateButton initWithimage:[UIImage imageNamed:@"unpitch"] target:self action:@selector(applePayBtnClick:)];
//        [_applePayBtn setTitle:@"Apple Pay" forState:UIControlStateNormal];
//        [_applePayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _applePayBtn.frame = CGRectMake((_bgView.bounds.size.width-84)/2.0+52, 100, (_bgView.bounds.size.width-84)/2.0, 35);
//        [_applePayBtn rightImageLeftText];
//        [_applePayBtn setImage:[UIImage imageNamed:@"pitch"] forState:UIControlStateSelected];
//        [_bgView addSubview:_applePayBtn];
        
    }
    return self;
}

- (void)payPalBtnClick:(UIButton *)btn{
    _cashBtn.selected = NO;
    _creditCard.selected = NO;
    _rewardPoint.selected = NO;
    if (!btn.isSelected) {
        btn.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(payStyleClickReturn:)]) {
        [self.delegate payStyleClickReturn:@"1"];
    }
}

- (void)applePayBtnClick:(UIButton *)btn{
    _payPalBtn.selected = NO;
    _creditCard.selected = NO;
    _cashBtn.selected = NO;
    if (!btn.isSelected) {
        btn.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(payStyleClickReturn:)]) {
        [self.delegate payStyleClickReturn:@"2"];
    }

}

- (void)rewardPointBtnClick:(UIButton *)btn{
    _payPalBtn.selected = NO;
    _creditCard.selected = NO;
    _cashBtn.selected = NO;
    if (!btn.isSelected) {
        btn.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(payStyleClickReturn:)]) {
        [self.delegate payStyleClickReturn:@"5"];
    }

}

- (void)setPayType:(NSString *)payType{
    _payType = payType;
    if ([_payType isEqualToString:@"0"] || [_payType isEqualToString:@"10"]) {
        _payPalBtn.selected = NO;
        _applePayBtn.selected = NO;
        _rewardPoint.selected = NO;
        _creditCard.selected = NO;
    }else if ([_payType isEqualToString:@"1"]){
        _payPalBtn.selected = YES;
        _applePayBtn.selected = NO;
        _rewardPoint.selected = NO;
        _creditCard.selected = NO;
    }else if ([_payType isEqualToString:@"2"]){
        _payPalBtn.selected = NO;
        _applePayBtn.selected = YES;
        _rewardPoint.selected = NO;
        _creditCard.selected = NO;
    }else if ([_payType isEqualToString:@"4"]){
        _payPalBtn.selected = NO;
        _cashBtn.selected = YES;
        _rewardPoint.selected = NO;
        _creditCard.selected = NO;
    }else if ([_payType isEqualToString:@"5"]){
        _payPalBtn.selected = NO;
        _cashBtn.selected = NO;
        _rewardPoint.selected = YES;
        _creditCard.selected = NO;
    }
}

- (void)setRewardP:(NSString *)rewardP{
    if (!rewardP) {
        rewardP = @"0";
    }
    if ([LanguageManager shareManager].language == 0) {
        _rpLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"Reward Point %@",rewardP] index:12 textColor:ButtonColor];
        
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"剩余%@饭点",rewardP]];
        [str addAttribute:NSForegroundColorAttributeName value:ButtonColor range:NSMakeRange(2,rewardP.length)];
        _rpLabel.attributedText = str;
    }
}

- (void)cashBtnClick:(UIButton *)btn{
    _payPalBtn.selected = NO;
    _creditCard.selected = NO;
    _rewardPoint.selected = NO;
    if (!btn.isSelected) {
        btn.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(payStyleClickReturn:)]) {
        [self.delegate payStyleClickReturn:@"4"];
    }

}

- (void)creditCardBtnClick:(UIButton *)btn{
    _payPalBtn.selected = NO;
    _cashBtn.selected = NO;
    _rewardPoint.selected = NO;
    if (!btn.isSelected) {
        btn.selected = YES;
    }
    if ([self.delegate respondsToSelector:@selector(payStyleClickReturn:)]) {
        [self.delegate payStyleClickReturn:@"3"];
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
