//
//  CartHeaderView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CartHeaderView.h"

@interface CartHeaderView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *rightImageV;
@property (nonatomic, strong) UIImageView *leftImageV;

@property (nonatomic, assign) BOOL isTap;

@end

@implementation CartHeaderView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isTap = NO;
        self.backgroundColor = [UIColor colorWithRed:194/255.0 green:226/255.0 blue:255/255.0 alpha:1];
        
        _nameLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.frame = CGRectMake(35, 0, SCREEN_WIDTH-35, 59);
        [self addSubview:_nameLabel];
        
        _rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(_nameLabel.bounds.size.width-16, 24, 6, 11.5)];
        _rightImageV.image = [UIImage imageNamed:@"right_icon"];
//        [_nameLabel addSubview:_rightImageV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
        [_nameLabel addGestureRecognizer:tap];
    }
    return self;
}

- (void)onTap{
    if ([self.delegate respondsToSelector:@selector(headerViewDidTap:)]) {
        [self.delegate headerViewDidTap:_section];
    }
}

- (void)setIsSubmit:(BOOL)isSubmit{
    _isSubmit = isSubmit;
    if (isSubmit) {
        _leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 19,19)];
        [self addSubview:_leftImageV];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-0.5, SCREEN_WIDTH-20, 0.5)];
        line.backgroundColor = ThemeBgColor;
        [self addSubview:line];
    }else{
        _leftBtn = [CreateButton initWithimage:[UIImage imageNamed:@"pitch_color"] target:self action:@selector(leftButtonClick:)];
        [_leftBtn setImage:[UIImage imageNamed:@"pitch"] forState:UIControlStateSelected];
        _leftBtn.frame = CGRectMake(0, 0, 35, 59);
        [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(22, 10, 22, 10)];
        _leftBtn.selected = YES;
        [self addSubview:_leftBtn];
    }
}

- (void)setSection:(MyShopCartSection *)section{
    _section = section;
    if (!_isSubmit) {
        if (_section.isSelect) {
            _leftBtn.selected = YES;
        }else{
            _leftBtn.selected = NO;
        }
    }else{
        [_leftImageV sd_setImageWithURL:[NSURL URLWithString:section.detailModel.store_image] placeholderImage:[UIImage imageNamed:@"subStore_default"]];
    }
    if ([LanguageManager shareManager].language == 0) {
        _nameLabel.text = section.detailModel.store_name_en;
    }else{
        _nameLabel.text = section.detailModel.store_name_cn;
    }
}

- (void)leftButtonClick:(UIButton *)btn{
    if (btn.isSelected){
        btn.selected = NO;
        _section.isSelect = NO;
    }else{
        btn.selected = YES;
        _section.isSelect = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(leftSelectButtonClick:)]) {
        [self.delegate leftSelectButtonClick:_section];
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
