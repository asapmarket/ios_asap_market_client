//
//  StoreDetailHeaderView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StoreDetailHeaderView.h"
#import "HomeServer.h"
#include "StringHeight.h"

@interface StoreDetailHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) VerticalAlignmentLabel *descLabel;

@property (nonatomic, strong) UILabel *restLabel;

@end

@implementation StoreDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 77, 77)];
    [self addSubview:_imageView];
    
    _nameLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_nameLabel];
    
    _restLabel = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentCenter font:[UIFont font10] textColor:RGB(232, 60, 60)];
    _restLabel.clipsToBounds = YES;
    _restLabel.backgroundColor = [UIColor whiteColor];
    _restLabel.layer.cornerRadius = 2;
    [self addSubview:_restLabel];
    
    _timeLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentLeft];
    _timeLabel.frame = CGRectMake(103, 36, SCREEN_WIDTH-113, 12);
    [self addSubview:_timeLabel];
    
    _addressLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentLeft];
    _addressLabel.frame = CGRectMake(103, 52, SCREEN_WIDTH-113, 12);
    [self addSubview:_addressLabel];
    
    _descLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentLeft];
    _descLabel.numberOfLines = 2;
    _descLabel.verticalAlignment = VerticalAlignmentTop;
    _descLabel.frame = CGRectMake(103, 68, SCREEN_WIDTH-113, 24);
    
    [self addSubview:_descLabel];
    
}

- (void)setDetailModel:(StoreDetailModel *)detailModel{
    _detailModel = detailModel;
   
    if ([LanguageManager shareManager].language == 0) {
        _nameLabel.text = _detailModel.store_name_en;
        _timeLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(kBusinessHours, nil), _detailModel.business_hours_en.length > 0 ? _detailModel.business_hours_en : @""];
        _addressLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(kAddress, nil), _detailModel.store_address_en.length>0?_detailModel.store_address_en : @""];
        _descLabel.text = [NSString stringWithFormat:@"intro:%@",detailModel.store_desc_en.length > 0 ? detailModel.store_desc_en : @""];
        CGFloat nameW = [StringHeight labelAutoCalculateRectWith:_detailModel.store_name_en FontSize:15 MaxSize:CGSizeMake(SCREEN_WIDTH-163, 16)];
        
        _nameLabel.frame = CGRectMake(103, 15, SCREEN_WIDTH-nameW, 17);
        _restLabel.frame = CGRectMake(113+nameW, 16, 45, 15);
        _restLabel.text = @"rest";
    }else{
        _nameLabel.text = _detailModel.store_name_cn;
        _timeLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(kBusinessHours, nil), _detailModel.business_hours_cn.length > 0 ? _detailModel.business_hours_cn : @""];
        _addressLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(kAddress, nil), _detailModel.store_address_cn.length > 0 ? _detailModel.store_address_cn : @""];
        _descLabel.text = [NSString stringWithFormat:@"简介：%@",detailModel.store_desc_cn.length > 0 ? detailModel.store_desc_cn : @""];
        CGFloat nameW = [StringHeight labelAutoCalculateRectWith:_detailModel.store_name_cn FontSize:15 MaxSize:CGSizeMake(SCREEN_WIDTH-163, 16)];
        
        _nameLabel.frame = CGRectMake(103, 15, SCREEN_WIDTH-nameW, 17);
        _restLabel.frame = CGRectMake(113+nameW, 16, 45, 15);
        _restLabel.text = @"打烊";
    }

    [_imageView sd_setImageWithURL:[NSURL URLWithString:detailModel.store_image] placeholderImage:[UIImage imageNamed:@"组-16"]];
    
    if (!detailModel.onwork){
        self.backgroundColor = RGB(232, 60, 60);
        _nameLabel.textColor = [UIColor whiteColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _addressLabel.textColor = [UIColor whiteColor];
        _descLabel.textColor = [UIColor whiteColor];
        
    }else{
        _nameLabel.frame = CGRectMake(103, 15, SCREEN_WIDTH-113, 17);
        _restLabel.hidden = YES;
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
