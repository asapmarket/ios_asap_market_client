//
//  FoodAddCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodAddCell.h"
#import "SpecListUtil.h"
#import "SpecIDBaseModel.h"

@interface FoodAddCell ()

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *minusBtn;

@property (nonatomic, assign) int foodCount;
@property (nonatomic, strong) SpecIDBaseModel *id_base_model;
@end

@implementation FoodAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
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
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _priceLabel.frame = CGRectMake(10, 20, 80, 17);
    
    _addBtn.frame = CGRectMake(SCREEN_WIDTH-34, 20, 24, 24);
    _countLabel.frame = CGRectMake(SCREEN_WIDTH-84, 20, 50, 24);
    _minusBtn.frame = CGRectMake(SCREEN_WIDTH-108, 20, 24, 24);
}

- (void)setFoodsModel:(FoodsDetailBaseModel *)foodsModel{
    _foodsModel = foodsModel;
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
    
    if ([self.delegate respondsToSelector:@selector(onAddButtonClick:)]) {
        [self.delegate onAddButtonClick:_foodsModel];
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

        if ([self.delegate respondsToSelector:@selector(onMinusButonClicl:)]) {
            [self.delegate onMinusButonClicl:_foodsModel];
        }
        return;
    }else if ([_foodsModel.has_spec isEqualToString:@"1"] && _foodsModel.count > 1){
        
        if ([self.delegate respondsToSelector:@selector(onMinusButonClicl:)]) {
            [self.delegate onMinusButonClicl:_foodsModel];
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
