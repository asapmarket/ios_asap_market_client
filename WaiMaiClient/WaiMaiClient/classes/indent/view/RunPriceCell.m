//
//  RunPriceCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/26.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunPriceCell.h"
#import "StringColor.h"

@interface RunPriceCell ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *paymentButton;
@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation RunPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = ThemeBgColor;
        [self addSubview:_line];
        
        _label1 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#1a1a1a"] textAlignment:NSTextAlignmentLeft];
        _label1.frame = CGRectZero;
        [self addSubview:_label1];
        
        _label2 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:ButtonColor textAlignment:NSTextAlignmentLeft];
        _label2.frame = CGRectZero;
        [self addSubview:_label2];
        
        _label3 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#1a1a1a"] textAlignment:NSTextAlignmentLeft];
        _label3.frame = CGRectZero;
        [self addSubview:_label3];
        
        _label4 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentLeft];
        _label4.frame = CGRectZero;
        [self addSubview:_label4];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:NSLocalizedString(@"CancelOrder", nil) forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor hexStringToColor:@"#333333"] forState:UIControlStateNormal];
        [_cancelButton.layer setMasksToBounds:YES];
        [_cancelButton.layer setCornerRadius:6.0];
        [_cancelButton.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
        [_cancelButton.layer setBorderColor:colorref];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_paymentButton setTitle:NSLocalizedString(@"ImmediatePayment", nil) forState:UIControlStateNormal];
        [_paymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _paymentButton.layer.cornerRadius = 6;
        _paymentButton.backgroundColor = ButtonColor;
        _paymentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_paymentButton addTarget:self action:@selector(paymentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_paymentButton];
        
        _promptLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        _promptLabel.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
        _promptLabel.numberOfLines = 0;
        [self addSubview:_promptLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    
    _label1.frame = CGRectMake(10, 19, 50, 17);
    
    _label2.frame = CGRectMake(55, 19, SCREEN_WIDTH-65, 17);
    
    _label3.frame = CGRectMake(10, 44, 50, 17);
    
    _label4.frame = CGRectMake(55, 44, SCREEN_WIDTH-65, 17);
    
    _cancelButton.frame = CGRectMake(10, 78, (SCREEN_WIDTH-30)/2.0, 44);
    _paymentButton.frame = CGRectMake(20+(SCREEN_WIDTH-30)/2.0, 78, (SCREEN_WIDTH-30)/2.0, 44);
    _promptLabel.frame = CGRectMake(0, self.height-42, SCREEN_WIDTH, 42);

}

- (void)setDetailModel:(RunOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    _label1.text = NSLocalizedString(kTotal, nil);
    if (!detailModel.total_money) {
        detailModel.total_money = @"";
    }
    if ([LanguageManager shareManager].language == 0) {
        _label2.text = [NSString stringWithFormat:@"$%@",detailModel.total_money];
        _label3.text = @"Time:";
    }else{
        _label2.text = [NSString stringWithFormat:@"$%@",detailModel.total_money];
        _label3.text = @"时间：";
    }
    _label4.text = detailModel.create_time;
    
    if ([LanguageManager shareManager].language == 0){
        _promptLabel.text = @"  Tip: We dont process unpaid order,you can pay for your order after we calculate the price";
    }else{
        _promptLabel.text = @"  提示： 尚未支付的订单不算作有效订单，请等待快递员反馈价格后尽快支付";
    }
    
    if (_detailModel.pay_state == 0 && [detailModel.state integerValue] == 8) {
        _cancelButton.hidden = NO;
        _paymentButton.hidden = NO;
        _promptLabel.hidden = YES;
    }else{
        _cancelButton.hidden = YES;
        _paymentButton.hidden = YES;
        _promptLabel.hidden = NO;
    }
}


- (void)cancelButtonClick{
    if (self.cancelButtonBlock) {
        self.cancelButtonBlock(_detailModel);
    }
}

- (void)paymentButtonClick{
    if (self.paymentButtonBlock) {
        self.paymentButtonBlock(_detailModel);
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
