//
//  MyMessageCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyMessageCell.h"

@interface MyMessageCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation MyMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _picImageView.layer.cornerRadius = 22;
        [self addSubview:_picImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor hexStringToColor:@"#808080"];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_timeLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = [UIColor hexStringToColor:@"#666666"];
        _detailLabel.font = [UIFont systemFontOfSize:10];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 2;
        [self addSubview:_detailLabel];

        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#EBEBEB"];
        [self addSubview:_line];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _picImageView.frame = CGRectMake(TableBorder, 20, 44, 44);
    _titleLabel.frame = CGRectMake(64, 22, SCREEN_WIDTH-140, 13);
    _timeLabel.frame = CGRectMake(SCREEN_WIDTH-80, 21, 70, 11);
    _detailLabel.frame = CGRectMake(64, 43, SCREEN_WIDTH-74, 25);
    _line.frame = CGRectMake(64, self.bounds.size.height-0.5, SCREEN_WIDTH-74, 0.5);

}

- (void)setModel:(MyMessageModel *)model{
    _picImageView.image = [UIImage imageNamed:@"subStore_default"];
    if ([LanguageManager shareManager].language == 0) {
        _timeLabel.text = model.create_time;
        _titleLabel.text = model.title_en;
        _detailLabel.text = model.content_en;
    }else{
        _timeLabel.text = model.create_time;
        _titleLabel.text = model.title_cn;
        _detailLabel.text = model.content_cn;
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
