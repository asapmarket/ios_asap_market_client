//
//  SelAddressCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SelAddressCell.h"

@interface SelAddressCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@end

@implementation SelAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_picImageView];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_addressLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor hexStringToColor:@"#999999"];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
        
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sexLabel.textColor = [UIColor hexStringToColor:@"#999999"];
        _sexLabel.font = [UIFont systemFontOfSize:13];
        _sexLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_sexLabel];
        
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.textColor = [UIColor hexStringToColor:@"#999999"];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_phoneLabel];
        
        _rightIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightIcon.image = [UIImage imageNamed:@"right_icon"];
        [self addSubview:_rightIcon];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = ThemeBgColor;
        _line.hidden = YES;
        [self addSubview:_line];
    }
    return self;
}

- (void)setModel:(AddressModel *)model{
    _model = model;
    _picImageView.image = [UIImage imageNamed:@"location"];

    _addressLabel.text = model.address;
    CGFloat width = model.extm_name.length*13+2;
    _nameLabel.frame = CGRectMake(35, 45, width, 13);
    _nameLabel.text = model.extm_name;
    _sexLabel.frame = CGRectMake(45+width, 45, 30, 13);
    if ([model.sex isEqualToString:@"0"]) {
        _sexLabel.text = NSLocalizedString(kWoman, nil);
    }else{
        _sexLabel.text = NSLocalizedString(kMan, nil);
    }
    _phoneLabel.frame = CGRectMake(85+width, 45, SCREEN_WIDTH-(150+width), 13);
    _phoneLabel.text = model.extm_phone;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _picImageView.frame = CGRectMake(TableBorder, 20, 15, 17);
    _addressLabel.frame = CGRectMake(35, 20, SCREEN_WIDTH-50, 15);
    _rightIcon.frame = CGRectMake(SCREEN_WIDTH-16, 28.5, 6, 17.5);
    _line.frame = CGRectMake(10, self.bounds.size.height-0.5, SCREEN_WIDTH-20, 0.5);

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
