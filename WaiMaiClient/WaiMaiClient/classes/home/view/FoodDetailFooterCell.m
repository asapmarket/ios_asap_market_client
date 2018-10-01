//
//  FoodDetailFooterCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodDetailFooterCell.h"

@interface FoodDetailFooterCell ()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation FoodDetailFooterCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageV];
        
        _nameLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageV.frame = CGRectMake(10, 30, SCREEN_WIDTH-20, 200);
    
    _nameLabel.frame = CGRectMake(10, 9, SCREEN_WIDTH-20, 12);
}

- (void)setModel:(FoodDetailModel *)model{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.content_image] placeholderImage:[UIImage imageNamed:@"detail_default2"]];
    
    if([LanguageManager shareManager].language == 0){
        _nameLabel.text = model.content_en;
    }else{
        _nameLabel.text = model.content_cn;
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
