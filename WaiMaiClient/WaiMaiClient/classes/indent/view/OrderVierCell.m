//
//  OrderVierCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderVierCell.h"
#import "OrderStateView.h"
#import "StringHeight.h"
#import "OrderSectionView.h"

@interface OrderVierCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) OrderStateView *stateView;
@property (nonatomic, strong) UIButton *detailButton;

@end

@implementation OrderVierCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ThemeBgColor;
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
        [_bgView addSubview:_line];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:view];
    }
    return self;
}

- (void)setModel:(OrderListModel *)model{
    _model = model;
    OrderSectionView *sectionView = [[OrderSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
    sectionView.order_id = model.order_id;
    [_bgView addSubview:sectionView];
    CGFloat height = 59;
    height += 19;
    if (model.store_list.count != 0) {
        for (int i=0; i<model.store_list.count; i++) {
            OrderModel *order = model.store_list[i];
            UILabel *label = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
            label.frame = CGRectMake(TableBorder, height-1, 200, 17);
            if ([LanguageManager shareManager].language == 0){
                label.text = order.store_name_en;
            }else{
                label.text = order.store_name_cn;
            }
            [_bgView addSubview:label];
            
            UILabel *countLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
            countLabel.frame = CGRectMake(220, height-1, SCREEN_WIDTH-230, 17);
            countLabel.text = [NSString stringWithFormat:@"%@%@",order.quantity,NSLocalizedString(kGoodsCount, nil)];
            [_bgView addSubview:countLabel];
            height += 34;
        }

    }
    
    _line.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 0.5);
    
    height += 0.5;
    
    _stateView = [[OrderStateView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 75)];
    _stateView.state = model.state;
    _stateView.exp_name = model.exp_name;
    [_bgView addSubview:_stateView];
    
    height += 95;
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(10, height-0.5, SCREEN_WIDTH-20, 0.5)];
    downLine.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
    [self addSubview:downLine];
    
    _detailButton = [CreateButton initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 45) title:NSLocalizedString(kLookDetail, nil) titleColor:ButtonColor font:[UIFont systemFontOfSize:15] target:self action:@selector(detailButtonClick:)];
    [_bgView addSubview:_detailButton];
    
    height += 45;
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
}

+ (CGFloat)cellHeightWithModel:(OrderListModel *)model{
    CGFloat height = 59;
    height += 19;
    height = height + model.store_list.count*34;
    height += 95.5;
    height += 55;
    
    return height;
}

- (void)detailButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(detailButtonClickWithModel:)]) {
        [self.delegate detailButtonClickWithModel:_model];
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
