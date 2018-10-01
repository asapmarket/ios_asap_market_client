//
//  IndentCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/23.
//  Copyright © 2017年 王. All rights reserved.
//

#import "IndentCell.h"

@interface IndentCell ()

@end

@implementation IndentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImageView.image = [UIImage imageNamed:@"receive"];
        [self.contentView addSubview:_leftImageView];
        
        _title = [self createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        
        _distance = [self createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
        
        _name = [self createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        
        _circle1 = [[UIView alloc] initWithFrame:CGRectZero];
        _circle1.backgroundColor = ButtonColor;
        _circle1.layer.cornerRadius = 1.5f;
        [self.contentView addSubview:_circle1];
        
        _location = [self createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
        [self.contentView addSubview:_line];
        
        _indentNo = [self createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        
        _time = [self createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        
        _circle2 = [[UIView alloc] initWithFrame:CGRectZero];
        _circle2.backgroundColor = ButtonColor;
        _circle2.layer.cornerRadius = 2.5f;
        [self.contentView addSubview:_circle2];
        
        _indentStatus = [self createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _leftImageView.sd_layout.leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self, 10)
    .heightIs(27)
    .widthIs(27);
    
    _title.sd_layout.leftSpaceToView(_leftImageView, 18)
    .topEqualToView(_leftImageView);
    [_title setMaxNumberOfLinesToShow:2];
    [_title setSingleLineAutoResizeWithMaxWidth:180];

    _distance.sd_layout.leftSpaceToView(_title, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self, 16);
    [_distance setSingleLineAutoResizeWithMaxWidth:80];
    
    _name.sd_layout.leftSpaceToView(self.contentView, 60)
    .topSpaceToView(_title, 10)
    .heightIs(13);
    [_name setSingleLineAutoResizeWithMaxWidth:100];

    
    _circle1.sd_layout.leftSpaceToView(_name, 10)
    .topSpaceToView(_title, 15)
    .heightIs(3)
    .widthIs(3);
    
    _location.sd_layout.leftSpaceToView(_circle1, 10)
    .topEqualToView(_name)
    .rightSpaceToView(self.contentView, 10);
    [_location setMaxNumberOfLinesToShow:2];
    [_location setSingleLineAutoResizeWithMaxWidth:180];

    
    _line.sd_layout.leftSpaceToView(self.contentView, 10)
    .topSpaceToView(_location, 10)
    .rightSpaceToView(self.contentView, 100)
    .heightIs(0.5);
    
    _indentNo.sd_layout.leftSpaceToView(self.contentView, 10)
    .topSpaceToView(_line, 10);
    [_indentNo setSingleLineAutoResizeWithMaxWidth:200];
    
    _time.sd_layout.leftSpaceToView(self, 10)
    .topSpaceToView(_indentNo, 10)
    .bottomSpaceToView(self, 10);
    [_time setSingleLineAutoResizeWithMaxWidth:200];

    _indentStatus.sd_layout.topSpaceToView(_line, 20)
    .rightSpaceToView(self, 10)
    .bottomSpaceToView(self, 20);
    
}

- (void)setItem:(IndentModel *)item{
    _title.text = item.time;
    _distance.attributedText = [self setTextColorWithString:[NSString stringWithFormat:@"距我%@",item.distance] index:2 textColor:ButtonColor];
    _name.text = @"小厨娘CN";
    _location.text = item.location;
    _indentNo.attributedText = [self setTextColorWithString:[NSString stringWithFormat:@"订单编号：%@",item.indentNo] index:5 textColor:[UIColor hexStringToColor:@"#999999"]];
    _time.attributedText = [self setTextColorWithString:@"接单时间：07-24 5:00" index:5 textColor:[UIColor hexStringToColor:@"#999999"]];
    _indentStatus.text = @"配送中";
    
    [self.contentView setupAutoHeightWithBottomViewsArray:@[_time, _indentStatus] bottomMargin:10];

    
}

- (NSAttributedString *)setTextColorWithString:(NSString *)string index:(NSUInteger)index textColor:(UIColor *)color{
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = [[textColor string] rangeOfString:[string substringFromIndex:index]];
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:range];
    return textColor;
}

- (UILabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = font;
    label.textColor = color;
    label.textAlignment = textAlignment;
    [self.contentView addSubview:label];
    return label;
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
