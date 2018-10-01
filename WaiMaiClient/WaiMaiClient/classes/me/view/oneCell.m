//
//  oneCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "oneCell.h"

@interface oneCell ()

@property (nonatomic, strong) UIImageView *orderImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UIView *line;

@end

@implementation oneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _orderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_orderImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _rightIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightIcon.image = [UIImage imageNamed:@"right_icon"];
        [self addSubview:_rightIcon];
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
        [self addSubview:_line];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    _rightIcon.frame = CGRectMake(SCREEN_WIDTH-16, 18.5, 6, 17.5);
    _line.frame = CGRectMake(TableBorder, self.bounds.size.height-1, SCREEN_WIDTH-20, 1);

}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    [super setFrame:frame];
}

- (void)setTitle:(NSString *)title icon:(NSString *)icon{
    _titleLabel.text = title;
    
    UIImage *image = [UIImage imageNamed:icon];
    _orderImageView.frame = CGRectMake(TableBorder, (55-image.size.height)/2.0, image.size.width, image.size.height);
    _orderImageView.image = image;
    _titleLabel.frame = CGRectMake(TableBorder+25, 0, SCREEN_WIDTH-120, 55);


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
