//
//  WMCouponsCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMCouponsCell.h"

@interface WMCouponsCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@property (nonatomic, strong) UILabel *rightLable;


@end

@implementation WMCouponsCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageV];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        if ([LanguageManager shareManager].language == 0) {
            _titleLabel.text = @"Coupons";
        }else{
            _titleLabel.text = @"优惠券";
        }
        [self addSubview:_titleLabel];
        
        _rightLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLable.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _rightLable.font = [UIFont systemFontOfSize:13];
        _rightLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightLable];
        
        _rightIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightIcon.image = [UIImage imageNamed:@"right_icon"];
        [self addSubview:_rightIcon];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _rightIcon.frame = CGRectMake(SCREEN_WIDTH-16, 18.5, 6, 17.5);
    UIImage *image = [UIImage imageNamed:@"coupons"];

    _imageV.frame = CGRectMake(TableBorder, (55-image.size.height)/2.0, image.size.width, image.size.height);
    _imageV.image = image;
    _titleLabel.frame = CGRectMake(TableBorder+25, 18, SCREEN_WIDTH-120, 19);
    _rightLable.frame = CGRectMake(SCREEN_WIDTH-170, 0, 140, self.bounds.size.height);

}

- (void)setCoupons:(NSString *)coupons{
    if (![coupons isEqualToString:NSLocalizedString(@"UseCoupons", nil)]) {
        _rightLable.textColor = [UIColor hexStringToColor:@"#ff1b1b"];
    }else{
        _rightLable.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    }
    _rightLable.text = coupons;
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
