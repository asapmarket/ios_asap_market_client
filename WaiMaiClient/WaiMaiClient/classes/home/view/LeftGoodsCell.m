//
//  LeftGoodsCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LeftGoodsCell.h"

@implementation LeftGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 53)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textColor = [UIColor hexStringToColor:@"#808080"];
        self.name.highlightedTextColor = [UIColor hexStringToColor:@"#333333"];
        [self.contentView addSubview:self.name];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : ThemeBgColor;
    self.highlighted = selected;
    self.name.highlighted = selected;

    // Configure the view for the selected state
}

@end
