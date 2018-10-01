//
//  HeadPhotoCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HeadPhotoCell.h"

@interface HeadPhotoCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UIView *line;

@end

@implementation HeadPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 5.5, 44, 44)];
        _photoImageView.clipsToBounds = YES;
        _photoImageView.layer.cornerRadius = 22;
        [self addSubview:_photoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = NSLocalizedString(kPhoto,nil);
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
    
    
    _titleLabel.frame = CGRectMake(TableBorder, CellBorder, SCREEN_WIDTH-120, 35);
    
    _rightIcon.frame = CGRectMake(SCREEN_WIDTH-16, 18.5, 6, 17.5);
    
    _line.frame = CGRectMake(TableBorder, self.bounds.size.height-1, SCREEN_WIDTH-20, 1);
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_photo"]];
    
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
