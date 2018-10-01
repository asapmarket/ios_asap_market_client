//
//  OrderHintCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/9/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderHintCell.h"

@interface OrderHintCell ()

@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@end

@implementation OrderHintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_iconImageV setImage:[UIImage imageNamed:@"smiling"]];
        [self addSubview:_iconImageV];
        
        _label1 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _label1.text = NSLocalizedString(kTIPS, nil);
        _label1.frame = CGRectZero;
        [self addSubview:_label1];
        
        _label2 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _label2.numberOfLines = 0;
        _label2.frame = CGRectZero;
        [self addSubview:_label2];
        
        
//        _label3 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
//        _label3.text = NSLocalizedString(@"aaaaa", nil);
//        _label3.frame = CGRectZero;
//        [self addSubview:_label3];
//        
//        _label4 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
//        _label4.text = NSLocalizedString(@"aaaaa", nil);
//        _label4.frame = CGRectZero;
//        [self addSubview:_label4];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _iconImageV.frame = CGRectMake(10, 19, 17, 17);
    _label1.frame = CGRectMake(35, 19, SCREEN_WIDTH-45, 17);
    
    _label2.frame = CGRectMake(35, 45, SCREEN_WIDTH-45, 80);
    NSString *str;
    if ([LanguageManager shareManager].language == 0) {
         str = @"We Charge 20% delivery fee from subtatall.\nYou can add dishes from mutiple different restaurants, a $2.0 processing fee will be added for each more restuarant.";
    }else{
        str = @"收取订单总价的20%\n每增加一个餐厅订单总价增加$2.0";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    _label2.attributedText = attributedString;
    
    [_label2 sizeToFit];
    
    
//    _label3.frame = CGRectMake(35, 63, SCREEN_WIDTH-45, 23);
//    
//    _label4.frame = CGRectMake(35, 86, SCREEN_WIDTH-45, 23);
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
