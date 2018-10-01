//
//  RunInstructionView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/4/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunInstructionView.h"

@interface RunInstructionView ()

@property (nonatomic, strong) UIButton *verityButton;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation RunInstructionView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, (SCREEN_HEIGHT-200)/2.0, SCREEN_WIDTH-20, 200)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8;
        [self addSubview:_bgView];
        
        _titleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
        _titleLabel.frame = CGRectMake(10, 10, _bgView.width-20, _bgView.height-64);
        _titleLabel.numberOfLines = 0;
        [_bgView addSubview:_titleLabel];
        
        _verityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _verityButton.frame = CGRectMake(0, _bgView.height-44, SCREEN_WIDTH-20, 44);
        _verityButton.backgroundColor = ButtonColor;
        [_verityButton setTitle:NSLocalizedString(kVerify,nil) forState:UIControlStateNormal];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_verityButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _verityButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _verityButton.layer.mask = maskLayer;
        [_verityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_verityButton addTarget:self action:@selector(verityButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_verityButton];
    }
    return self;
}

-  (void)setInstruction:(NSString *)instruction{
    _titleLabel.text = instruction;
}

- (void)verityButtonClick{
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
