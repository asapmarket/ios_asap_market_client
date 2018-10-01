//
//  OrderPriceCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/9/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderPriceCell.h"
#import "StringColor.h"

@interface OrderPriceCell ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UIView *line;

@end

@implementation OrderPriceCell

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
}

- (void)setBaseModel:(OrderDetailBaseModel *)baseModel{
    _label1.text = NSLocalizedString(kTotal, nil);
    if ([LanguageManager shareManager].language == 0) {
        _label2.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"$%@(Include Delivery fee $%@+Tax $%@)",baseModel.total_money, baseModel.yunfei, baseModel.tax] index:baseModel.total_money.length+1 textColor:[UIColor hexStringToColor:@"#494949"]];
        _label3.text = @"Time:";
    }else{
        _label2.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"$%@(包含配送费$%@+税费$%@)",baseModel.total_money, baseModel.yunfei, baseModel.tax] index:baseModel.total_money.length+1 textColor:[UIColor hexStringToColor:@"#494949"]];
        _label3.text = @"时间：";
    }
    _label4.text = baseModel.create_time;
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
