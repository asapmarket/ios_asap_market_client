//
//  OrderStoreListCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderStoreListCell.h"
#import "StringColor.h"

@interface OrderStoreListCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation OrderStoreListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_nameLabel];
        
        _countLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
        [self addSubview:_countLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _nameLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-120, 17);
    _countLabel.frame = CGRectMake(SCREEN_WIDTH-110, 0, 100, 17);
}

- (void)setStoreModel:(OrderDetailStoreModel *)storeModel{
    if ([LanguageManager shareManager].language == 0) {
        _nameLabel.text = storeModel.store_name_en;
    }else{
        _nameLabel.text = storeModel.store_name_cn;
    }
    _countLabel.text = [NSString stringWithFormat:@"%@%@",storeModel.foods_count,NSLocalizedString(kGoodsCount, nil)];
    
    CGFloat height = 34;
    if (storeModel.foods_list.count == 0) {
        return;
    }
    for (int i=0; i< storeModel.foods_list.count; i++) {
        OrderDetailFoodModel *model = storeModel.foods_list[i];
        UILabel *foodLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4D4D4D"] textAlignment:NSTextAlignmentLeft];
        foodLabel.frame = CGRectMake(20, height, SCREEN_WIDTH-200, 15);
        [self addSubview:foodLabel];
        
        UILabel *priceLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4D4D4D"] textAlignment:NSTextAlignmentLeft];
        priceLabel.frame = CGRectMake(SCREEN_WIDTH-180, height, 100, 15);
        [self addSubview:priceLabel];
        
        UILabel *stateLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4D4D4D"] textAlignment:NSTextAlignmentRight];
        stateLabel.frame = CGRectMake(SCREEN_WIDTH-70, height, 60, 15);
        [self addSubview:stateLabel];
        
        if ([LanguageManager shareManager].language == 0) {
            foodLabel.text = model.foods_name_en;
        }else{
            foodLabel.text = model.foods_name_cn;
        }
        
        priceLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"$%@*%@",model.price,model.foods_quantity] index:model.price.length+1 textColor:[UIColor hexStringToColor:@"#999999"]];
        
        stateLabel.text = model.state;
        
        height += 32;
    }
    
}

+ (CGFloat)cellHeightWithModel:(OrderDetailStoreModel *)model{
    CGFloat height = 34;
    if (model.foods_list.count == 0) {
        return height;
    }
    
    height += model.foods_list.count*33;
    
    return height;
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
