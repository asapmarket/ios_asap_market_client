//
//  CreditCardCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/9/19.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CreditCardCell.h"

@interface CreditCardCell ()

@property (nonatomic, strong) UILabel *cardNoLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIImageView *bgImageV;


@end

@implementation CreditCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _bgImageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageV.image = [UIImage imageNamed:@"card_bg"];
        _bgImageV.userInteractionEnabled = YES;
        [self addSubview:_bgImageV];
        
        _cardNoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cardNoLabel.textColor = [UIColor hexStringToColor:@"#ffffff"];
        _cardNoLabel.font = [UIFont systemFontOfSize:28];
        _cardNoLabel.textAlignment = NSTextAlignmentLeft;
        [_bgImageV addSubview:_cardNoLabel];
        
//        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _dateLabel.textColor = [UIColor hexStringToColor:@"#333333"];
//        _dateLabel.font = [UIFont systemFontOfSize:15];
//        _dateLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:_dateLabel];
        
//        _line = [[UIView alloc] initWithFrame:CGRectZero];
//        _line.backgroundColor = [UIColor hexStringToColor:@"#e6e6e6"];
//        [self addSubview:_line];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:NSLocalizedString(KDelete, nil) forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor hexStringToColor:@"#ffffff"] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn.layer setMasksToBounds:YES];
        [_deleteBtn.layer setCornerRadius:4.0]; //设置矩圆角半径
        [_deleteBtn.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255/255.0, 255/255.0, 255/255.0, 1 });
        [_deleteBtn.layer setBorderColor:colorref];//边框颜色
        [_bgImageV addSubview:_deleteBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bgImageV.frame = CGRectMake((SCREEN_WIDTH-355)/2.0, 10, 355, 148.5);
    _cardNoLabel.frame = CGRectMake(40, 50, SCREEN_WIDTH-100, 30);
//    _dateLabel.frame = CGRectMake(10, 35, SCREEN_WIDTH-90, 17);
//    _line.frame = CGRectMake(10, 49.5, SCREEN_WIDTH-20, 0.5);
    _deleteBtn.frame = CGRectMake(_bgImageV.bounds.size.width-82, 100, 72, 26);
}

- (void)setModel:(PaymentItem *)model{
    _model = model;
    
    _cardNoLabel.text = [NSString stringWithFormat:@"**** **** **** %@",[model.cardNo substringWithRange:NSMakeRange(model.cardNo.length-4, 4)]];
}

- (void)deleteBtnClick{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:_model];
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
