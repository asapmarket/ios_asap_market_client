//
//  SubmitFoodCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SubmitFoodCell.h"

@interface SubmitFoodCell ()

@property (nonatomic, strong) UILabel *foodLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation SubmitFoodCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _foodLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        _foodLabel.numberOfLines = 0;
        [self addSubview:_foodLabel];
        
        _countLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_countLabel];
        
        _priceLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentRight];
        [self addSubview:_priceLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _foodLabel.frame = CGRectMake(35, 0, SCREEN_WIDTH-155, 40);
    _countLabel.frame = CGRectMake(SCREEN_WIDTH-110, 0, 40, 40);
    _priceLabel.frame = CGRectMake(SCREEN_WIDTH-65, 0, 55, 40);
}

- (void)setListModel:(FoodsListModel *)listModel{
    if ([LanguageManager shareManager].language == 0) {
        if (listModel.specName_cn) {
            _foodLabel.text = [NSString stringWithFormat:@"%@_%@",listModel.foods_name_en, listModel.specName_en];
        }else{
            _foodLabel.text = listModel.foods_name_en;
        }
    }else{
        if (listModel.specName_cn) {
            _foodLabel.text = [NSString stringWithFormat:@"%@_%@",listModel.foods_name_cn, listModel.specName_cn];
        }else{
            _foodLabel.text = listModel.foods_name_cn;
        }
    }
    if (listModel.specAllID) {
        _countLabel.text = [NSString stringWithFormat:@"*%d",listModel.specCount];
        _priceLabel.text = [NSString stringWithFormat:@"$%.2f",listModel.specCount*[listModel.price floatValue]];

    }else{
        _countLabel.text = [NSString stringWithFormat:@"*%d",listModel.count];
        _priceLabel.text = [NSString stringWithFormat:@"$%.2f",listModel.count*[listModel.price floatValue]];

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
