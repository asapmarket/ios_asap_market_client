//
//  ExchangeView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/12/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ExchangeView.h"
#import "VerticalAlignmentLabel.h"
#import "StringColor.h"

@interface ExchangeView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) VerticalAlignmentLabel *label3;
@property (nonatomic, strong) VerticalAlignmentLabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UILabel *label6;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *btn;

@end


@implementation ExchangeView

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
    _label1.text = NSLocalizedString(kNowBalance, nil);
    [_bgView addSubview:_label1];
    
    height += 24;
    
    _label2 = [CreateLabel createLabelWithFont:[UIFont boldSystemFontOfSize:19.5] textColor:[UIColor hexStringToColor:@"#3c9efa"] textAlignment:NSTextAlignmentCenter];
    _label2.frame = CGRectMake(10, height, SCREEN_WIDTH-40, 26);
    [_bgView addSubview:_label2];
    
    height += 40;
    
    _label3 = [[VerticalAlignmentLabel alloc] initWithFrame:CGRectMake(10, height, (SCREEN_WIDTH-60)/2.0, 40)];
    _label3.font = [UIFont systemFontOfSize:10];
    _label3.textColor = [UIColor hexStringToColor:@"#808080"];
    _label3.textAlignment = NSTextAlignmentRight;
    _label3.verticalAlignment = VerticalAlignmentTop;
    _label3.numberOfLines = 3;
    [_bgView addSubview:_label3];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2.0+19.5, height, 1, 10)];
    _lineView.backgroundColor = [UIColor hexStringToColor:@"#2198f6"];
    [_bgView addSubview:_lineView];
    
    _label4 = [[VerticalAlignmentLabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2.0+30, height, (SCREEN_WIDTH-60)/2.0, 40)];
    _label4.font = [UIFont systemFontOfSize:10];
    _label4.textColor = [UIColor hexStringToColor:@"#808080"];
    _label4.textAlignment = NSTextAlignmentLeft;
    _label4.verticalAlignment = VerticalAlignmentTop;
    _label4.numberOfLines = 3;
    [_bgView addSubview:_label4];
    
    height += 60;
    _label6 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#ff0000"] textAlignment:NSTextAlignmentCenter];
    _label6.frame = CGRectMake(10, height, SCREEN_WIDTH-40, 12);
    _label6.text = NSLocalizedString(kWalletLabel5, nil);
    _label6.hidden = YES;
    [_bgView addSubview:_label6];
    
    height += 20;
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(TableBorder, height, SCREEN_WIDTH-40, 44.5);
    _btn.layer.cornerRadius = 5;
    [_btn setTitle:NSLocalizedString(kExchange, nil) forState:UIControlStateNormal];
    _btn.backgroundColor = ButtonColor;
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_btn];
    
    height += 60;
    _label5 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentCenter];
    _label5.frame = CGRectMake(10, height, SCREEN_WIDTH-40, 12);
    [_bgView addSubview:_label5];
    
}

- (void)setModel:(WalletModel *)model{
    _model = model;
    _label2.text = model.money;
    if ([LanguageManager shareManager].language == 0) {
        _label3.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"Current ratio %d:%d",[model.min_exchange intValue]*[model.ratio intValue], [model.min_exchange intValue]] index:14 textColor:ButtonColor];
        _label4.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"Total exchange amount %.2f",[model.total_money floatValue]] index:22 textColor:ButtonColor];
        _label5.text = [NSString stringWithFormat:@"To be redeemable for %d meal points",[model.ratio intValue]*[model.min_exchange intValue]];
    }else{
        _label3.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"当前兑换比例 %d ：%d",[model.min_exchange intValue]*[model.ratio intValue], [model.min_exchange intValue]] index:7 textColor:ButtonColor];
        _label4.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"总计兑换金额 %.2f",[model.total_money floatValue]] index:7 textColor:ButtonColor];
        _label5.text = [NSString stringWithFormat:@"需满%d可兑换金额才可兑换饭点",[model.ratio intValue]*[model.min_exchange intValue]];

    }
        
    
    if ([model.point_add intValue] == 0) {
        _label6.hidden = NO;
    }else{
        _label6.hidden = YES;
    }
    
    
}

- (void)exchange{
    if ([self.delegate respondsToSelector:@selector(exchangeButtonDidClick:)]) {
        [self.delegate exchangeButtonDidClick:_model];
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
