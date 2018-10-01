//
//  WMPriceCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMPriceCell.h"
#import "StringHeight.h"

@interface WMPriceCell ()

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UILabel *label5;

@end

    
@implementation WMPriceCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        _label1 = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentRight font:[UIFont font13] textColor:RGB(128, 128, 128)];
        [self addSubview:_label1];
        
        _label2 = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentRight font:[UIFont font13] textColor:RGB(128, 128, 128)];
        [self addSubview:_label2];
        
        _label3 = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentRight font:[UIFont font13] textColor:RGB(128, 128, 128)];
        [self addSubview:_label3];
        
        _label4 = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:19] textColor:RGB(33, 150, 243)];
        [self addSubview:_label4];
        
        _label5 = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#ff1b1b"]];
        [self addSubview:_label5];
        
        _label5.hidden = YES;

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _label1.frame = CGRectMake(0, 15, kScreenWidth-20, 23);
    _label2.frame = CGRectMake(0, 38, kScreenWidth-20, 23);
    
    if (_model) {
        CGFloat priceW = [StringHeight labelAutoCalculateRectWith:[NSString stringWithFormat:@"$%@",_model.total_money] FontSize:19 MaxSize:CGSizeMake(100, 25)];
        
        _label3.frame = CGRectMake(0, 61, kScreenWidth-20-priceW, 23);
        _label4.frame = CGRectMake(kScreenWidth-priceW-10, 61, priceW, 23);
    }
    
    if (_couponsModel) {
        _label5.frame = CGRectMake(0, 61, kScreenWidth-20, 23);
        CGFloat priceW = [StringHeight labelAutoCalculateRectWith:[NSString stringWithFormat:@"$%@",_model.total_money] FontSize:19 MaxSize:CGSizeMake(100, 25)];
        _label5.hidden = NO;
        _label3.frame = CGRectMake(0, 84, kScreenWidth-20-priceW, 23);
        _label4.frame = CGRectMake(kScreenWidth-priceW-10, 84, priceW, 23);
    }
    
   
}

- (void)setModel:(AmoutModel *)model{
    _model = model;
    
    if ([LanguageManager shareManager] == 0) {
        _label1.text = [NSString stringWithFormat:@"Freight:$%@",_model.yunfei];
        _label2.text = [NSString stringWithFormat:@"Tax:$%@",_model.tax];
        _label3.text = [NSString stringWithFormat:@"Total:"];
        _label4.text = [NSString stringWithFormat:@"$%@",_model.total_money];
    }else{
        _label1.text = [NSString stringWithFormat:@"配送费:$%@",_model.yunfei];
        _label2.text = [NSString stringWithFormat:@"税:$%@",_model.tax];
        _label3.text = [NSString stringWithFormat:@"合计:"];
        _label4.text = [NSString stringWithFormat:@"$%@",_model.total_money];
    }
    
}

- (void)setCouponsModel:(WMUserCouponsModel *)couponsModel{
    _couponsModel = couponsModel;
    if ([LanguageManager shareManager] == 0) {
        _label1.text = [NSString stringWithFormat:@"Freight:$%@",_couponsModel.yunfei];
        _label2.text = [NSString stringWithFormat:@"Tax:$%@",_couponsModel.tax];
        _label3.text = [NSString stringWithFormat:@"Total:"];
        _label4.text = [NSString stringWithFormat:@"$%@",_couponsModel.total_money];
        _label5.text = [NSString stringWithFormat:@"Coupon discount:-$%@",_couponsModel.COUPON_MONEY];

    }else{
        _label1.text = [NSString stringWithFormat:@"配送费:$%@",_couponsModel.yunfei];
        _label2.text = [NSString stringWithFormat:@"税:$%@",_couponsModel.tax];
        _label3.text = [NSString stringWithFormat:@"合计:"];
        _label4.text = [NSString stringWithFormat:@"$%@",_couponsModel.total_money];
        _label5.text = [NSString stringWithFormat:@"优惠券折扣：-$%@",_couponsModel.COUPON_MONEY];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
