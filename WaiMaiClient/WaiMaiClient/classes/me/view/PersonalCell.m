//
//  PersonalCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "PersonalCell.h"

@interface PersonalCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation PersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView) name:UserInfoChange object:nil];
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _photoImageView.clipsToBounds = YES;

        [self addSubview:_photoImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];

        [self updateView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _photoImageView.frame = CGRectMake((SCREEN_WIDTH-57)/2, 35, 57, 57);
    _photoImageView.layer.cornerRadius = 28.5;
    _nameLabel.frame = CGRectMake(TableBorder, 110, SCREEN_WIDTH-2*TableBorder, 18);
}

- (void)updateView{
    
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];

    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.head_image] placeholderImage:[UIImage imageNamed:@"photo"]];
    
    _nameLabel.text = userInfo.nick_name;
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
