//
//  BalanceView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/12/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BalanceView.h"

@interface BalanceView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation BalanceView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowColor = [UIColor hexStringToColor:@"2193f8"].CGColor;
        self.layer.shadowRadius = 5;
        self.layer.shadowOffset  = CGSizeMake(0.6, 0.6);
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    [self addSubview:_bgView];
    
    CGFloat height = 60;
    if (IS_IPHONE_5) {
        height = 30;
    }
    _label1 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:12.5] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentCenter];
    _label1.frame = CGRectMake(10, height, SCREEN_WIDTH-40, 14);
    _label1.text = NSLocalizedString(kRewardPointBalance, nil);
    [_bgView addSubview:_label1];
    
    height += 34;
    
    _label2 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:25.5] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentCenter];
    _label2.frame = CGRectMake(10, height, SCREEN_WIDTH-40, 26);
    [_bgView addSubview:_label2];
    
    height += 40;
    
    _btn = [CreateButton creatButtonWithFrame:CGRectMake(20, height, SCREEN_WIDTH-60, 20) title:NSLocalizedString(kWhatIsRewardPoint, nil) backCoclor:[UIColor whiteColor] tittleColor:[UIColor hexStringToColor:@"#2196f3"] font:[UIFont systemFontOfSize:10.5] target:self action:@selector(questionBtn)];
    [_btn setImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    if ([LanguageManager shareManager].language == 0){
        _btn.imageEdgeInsets = UIEdgeInsetsMake(4, 15, 4, 25);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        _btn.imageEdgeInsets = UIEdgeInsetsMake(4, 20, 4, 20);
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    
    [_bgView addSubview:_btn];
    
}

- (void)setModel:(WalletModel *)model{
    _model = model;
    _label2.text = model.point;
}

- (void)questionBtn{
    if ([self.delegate respondsToSelector:@selector(rewardPointDidClick:)]) {
        [self.delegate rewardPointDidClick:_model];
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
