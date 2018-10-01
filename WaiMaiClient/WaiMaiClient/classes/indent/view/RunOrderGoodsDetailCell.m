//
//  RunOrderGoodsDetailCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderGoodsDetailCell.h"
#import "StringHeight.h"

@interface RunOrderGoodsDetailCell ()

@property (nonatomic, strong) UILabel *addrTitleLabel;
@property (nonatomic, strong) UILabel *cantactLabel;
@property (nonatomic, strong) UILabel *addrLabel;
@property (nonatomic, strong) UILabel *goodsDesLabel;
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIView *imageBgV;

@end

@implementation RunOrderGoodsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _addrTitleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _addrTitleLabel.text = NSLocalizedString(@"ShippingAddress", nil);
        [self addSubview:_addrTitleLabel];
        
        _cantactLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_cantactLabel];
        
        _addrLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_addrLabel];
        
        _goodsDesLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_goodsDesLabel];
        
        _desLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        _desLabel.numberOfLines = 0;
        [self addSubview:_desLabel];
        
        _line1 = [[UIView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
        [self addSubview:_line1];
        
        _line2 = [[UIView alloc] initWithFrame:CGRectZero];
        _line2.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
        [self addSubview:_line2];
        
        _promptLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        _promptLabel.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
        _promptLabel.numberOfLines = 0;
        [self addSubview:_promptLabel];
        
        _imageBgV = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageBgV];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _addrTitleLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 17);
    _cantactLabel.frame = CGRectMake(10, 44, SCREEN_WIDTH-20, 15);
    _addrLabel.frame = CGRectMake(10, 67, SCREEN_WIDTH-20, 15);
    _line1.frame = CGRectMake(10, 100, SCREEN_WIDTH-20, 0.5);
    
    _goodsDesLabel.frame = CGRectMake(10, 119, SCREEN_WIDTH-20, 17);
    CGFloat remarkH = [StringHeight heightFromString:_detailModel.remark withFont:15 constraintToWidth:SCREEN_WIDTH-20];
    _desLabel.frame = CGRectMake(10, 144, SCREEN_WIDTH-20, remarkH);
    _imageBgV.frame = CGRectMake(0, 158+remarkH, SCREEN_WIDTH, 62);
    _promptLabel.frame = CGRectMake(0, 235+remarkH, SCREEN_WIDTH, 42);
}

- (void)setDetailModel:(RunOrderDetailModel *)detailModel{
    _detailModel = detailModel;

    _cantactLabel.text = [NSString stringWithFormat:@"%@ | %@",detailModel.cust_name, detailModel.cust_phone];
    _goodsDesLabel.text = NSLocalizedString(@"CommodityDescription", nil);
    _addrLabel.text = detailModel.cust_address;
    _desLabel.text = detailModel.remark;
    if (detailModel.imgs.count > 0) {
        _imageBgV.hidden = NO;
        for (int i=0; i< detailModel.imgs.count; i++) {
            RunOrderImgsModel *img = [RunOrderImgsModel mj_objectWithKeyValues:detailModel.imgs[i]];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10+(10+(SCREEN_WIDTH-60)/5.0)*i, 0, (SCREEN_WIDTH-60)/5.0, (SCREEN_WIDTH-60)/5.0)];
            imageV.userInteractionEnabled = YES;
            [imageV sd_setImageWithURL:[NSURL URLWithString:img.path]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTouch)];
            [imageV addGestureRecognizer:tap];
            [_imageBgV addSubview:imageV];
        }
    }else{
        _imageBgV.hidden = YES;
    }
    if ([LanguageManager shareManager].language == 0){
        _promptLabel.text = @"  Tip: We dont process unpaid order,you can pay for your order after we calculate the price";
    }else{
        _promptLabel.text = @"  提示： 尚未支付的订单不算作有效订单，请等待快递员反馈价格后尽快支付";
    }
}

- (void)imageViewDidTouch{
    if (self.imageViewDidTouchBlock) {
        self.imageViewDidTouchBlock(_detailModel);
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
