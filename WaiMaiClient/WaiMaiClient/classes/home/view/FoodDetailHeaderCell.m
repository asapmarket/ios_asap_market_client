//
//  FoodDetailHeaderCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodDetailHeaderCell.h"

@interface FoodDetailHeaderCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation FoodDetailHeaderCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageV.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageV];
        
        _nameLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_nameLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = ThemeBgColor;
        [self addSubview:_line];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
    
    _nameLabel.frame = CGRectMake(10, 229, SCREEN_WIDTH-20, 19);
    
    _line.frame = CGRectMake(10, self.bounds.size.height-0.5, SCREEN_WIDTH-20, 0.5);
}

- (void) setBaseModel:(FoodsDetailBaseModel *)baseModel{
    _baseModel = baseModel;
    
    if([LanguageManager shareManager].language == 0){
        _nameLabel.text = baseModel.foods_name_en;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:baseModel.foods_name_en] placeholderImage:[UIImage imageNamed:@"detail_default1"]];

    }else{
        _nameLabel.text = baseModel.foods_name_cn;
        [_imageV sd_setImageWithURL:[NSURL URLWithString:baseModel.foods_name_cn] placeholderImage:[UIImage imageNamed:@"detail_default1"]];
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
