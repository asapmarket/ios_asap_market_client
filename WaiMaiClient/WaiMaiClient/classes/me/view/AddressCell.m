//
//  AddressCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation AddressCell

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
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#e6e6e6"];
        [self addSubview:_line];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:NSLocalizedString(kEdit, nil) forState:UIControlStateNormal];
        [_editBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_editBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _picImageView.frame = CGRectMake(TableBorder, 20, 15, 15);
    _addressLabel.frame = CGRectMake(35, 20, SCREEN_WIDTH-105, 15);
    _editBtn.frame = CGRectMake(SCREEN_WIDTH-60, 20, 60, 35);
}

- (void)setModel:(AddressModel *)model{
    _model = model;
    if ([model.is_default isEqualToString:@"0"]) {
        _picImageView.image = [UIImage imageNamed:@"unpitch"];
    }else{
        _picImageView.image = [UIImage imageNamed:@"pitch"];
    }
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

- (void)setDefaultAddressWithStatus:(NSString *)status{
    if ([status isEqualToString:@"0"]) {
        _picImageView.image = [UIImage imageNamed:@"unpitch"];
    }else{
        _picImageView.image = [UIImage imageNamed:@"pitch"];
    }
}

- (void)editBtnClick{
    if ([self.delegate respondsToSelector:@selector(editButtonClick:)]) {
        [self.delegate editButtonClick:_model];
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
