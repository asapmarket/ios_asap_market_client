    //
//  RightGoodsCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "RightGoodsCell.h"

#define Vieww (SCREEN_WIDTH-80)

@interface RightGoodsCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *minusBtn;

@end

@implementation RightGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageV];
        
        _nameLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_nameLabel];
        
        _descLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentLeft];
        _descLabel.numberOfLines = 2;
        [self addSubview:_descLabel];
        
        _priceLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:ButtonColor textAlignment:NSTextAlignmentLeft];
        [self addSubview:_priceLabel];
        
        _addBtn = [CreateButton initWithimage:[UIImage imageNamed:@"add_click"] target:self action:@selector(addButtonClick:)];
        [self addSubview:_addBtn];
        
        _minusBtn = [CreateButton initWithimage:[UIImage imageNamed:@"minus_click"] target:self action:@selector(minusButtonClick:)];
        _minusBtn.hidden = YES;
        [self addSubview:_minusBtn];
        
        _countLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:17] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
        _countLabel.hidden = YES;
        [self addSubview:_countLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = ThemeBgColor;
        [self addSubview:_line];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageV.frame = CGRectMake(10, 20, 62, 62);
    _nameLabel.frame = CGRectMake(82, 20, Vieww-92, 15);
    _descLabel.frame = CGRectMake(82, 39, Vieww-92, 24);
    _priceLabel.frame = CGRectMake(82, 65, 60, 17);
    
    _addBtn.frame = CGRectMake(Vieww-34, 69, 24, 24);
    _countLabel.frame = CGRectMake(Vieww-84, 69, 50, 24);
    _minusBtn.frame = CGRectMake(Vieww-108, 69, 24, 24);
    _line.frame = CGRectMake(10, 102.5, Vieww-20, 0.5);
}

- (void)setTypeModel:(FoodsTypeModel *)typeModel{
    _typeModel = typeModel;
}

- (void)setFoodsModel:(FoodsListModel *)foodsModel{
    _foodsModel = foodsModel;
    if ([LanguageManager shareManager].language == 0) {
        [_imageV sd_setImageWithURL:[NSURL URLWithString:foodsModel.foods_image_en] placeholderImage:[UIImage imageNamed:@"组-16"]];
        _nameLabel.text = foodsModel.foods_name_en;
        _descLabel.text = foodsModel.foods_desc_en;
    }else{
        [_imageV sd_setImageWithURL:[NSURL URLWithString:foodsModel.foods_image_cn] placeholderImage:[UIImage imageNamed:@"组-16"]];
        _nameLabel.text = foodsModel.foods_name_cn;
        _descLabel.text = foodsModel.foods_desc_cn;
    }
    _priceLabel.text = [NSString stringWithFormat:@"$%.2f",[foodsModel.price doubleValue]];
    
    if (foodsModel.count > 0) {
        _minusBtn.hidden = NO;
        _countLabel.hidden = NO;
        _countLabel.text = [NSString stringWithFormat:@"%d",foodsModel.count];
    }else{
        _minusBtn.hidden = YES;
        _countLabel.hidden = YES;
        _countLabel.text = [NSString stringWithFormat:@"%d",foodsModel.count];
    }

}

- (void)addButtonClick:(UIButton *)btn{
    
    if ([_foodsModel.has_spec isEqualToString:@"0"] || _foodsModel.spec_class_list.count == 0 || _foodsModel.has_spec == nil ) {
        _foodsModel.specAllID = nil;
        _foodsModel.count ++;
    }
    
    if ([self.delegate respondsToSelector:@selector(onAddButtonClick:typeModel:rightCell:)]) {
        [self.delegate onAddButtonClick:_foodsModel typeModel:_typeModel rightCell:self];
    }
    if (_foodsModel.count > 0) {
        _minusBtn.hidden = NO;
        _countLabel.hidden = NO;
        _countLabel.text = [NSString stringWithFormat:@"%d",_foodsModel.count];
    }

}

- (void)minusButtonClick:(UIButton *)btn{
    if (([_foodsModel.has_spec isEqualToString:@"0"] && _foodsModel.count > 1) || _foodsModel.count == 1) {
        _foodsModel.count --;
        if (_foodsModel.count == 0 ) {
            _minusBtn.hidden = YES;
            _countLabel.hidden = YES;
            _foodsModel.count = 0;
        }else{
            _countLabel.text = [NSString stringWithFormat:@"%d",_foodsModel.count];
        }
        
        if (_foodsModel.specCount == 1){
            _foodsModel.specCount = 0;
        }
        
        if ([self.delegate respondsToSelector:@selector(onMinusButonClicl:typeModel:rightCell:)]) {
            [self.delegate onMinusButonClicl:_foodsModel typeModel:_typeModel rightCell:self];
        }

        return;
    }else if ([_foodsModel.has_spec isEqualToString:@"1"] && _foodsModel.count > 1){
        
        if ([self.delegate respondsToSelector:@selector(onMinusButonClicl:typeModel:rightCell:)]) {
            [self.delegate onMinusButonClicl:_foodsModel typeModel:_typeModel rightCell:self];
        }
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
