//
//  RunOrderCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderCell.h"
#import "RunOrderStateView.h"
#import "OrderSectionView.h"
#import "StringHeight.h"

@interface RunOrderCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) RunOrderStateView *stateView;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UILabel *remarkLabel;

@end

@implementation RunOrderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ThemeBgColor;
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _line1 = [[UIView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
        [_bgView addSubview:_line1];
        
        _line2 = [[UIView alloc] initWithFrame:CGRectZero];
        _line2.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
        [_bgView addSubview:_line2];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:view];
        
        _remarkLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        _remarkLabel.numberOfLines = 0;
        [_bgView addSubview:_remarkLabel];
        
    }
    return self;
}

- (void)setItem:(RunOrderItem *)item{
    _item = item;
    OrderSectionView *sectionView = [[OrderSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
    sectionView.order_id = item.order_id;
    [_bgView addSubview:sectionView];
    CGFloat height = 59;
    height += 9;
    
    CGFloat remarkH = [StringHeight heightFromString:item.remark withFont:15 constraintToWidth:SCREEN_WIDTH-20];

    _remarkLabel.frame = CGRectMake(10, height, SCREEN_WIDTH-20, remarkH);
    _remarkLabel.text = item.remark;
    height += remarkH;
    height += 10;
    if (item.imgs.count > 0) {
        for (int i=0; i< item.imgs.count; i++) {
            RunOrderImgsModel *img = [RunOrderImgsModel mj_objectWithKeyValues:item.imgs[i]];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10+(10+(SCREEN_WIDTH-60)/5.0)*i, height, (SCREEN_WIDTH-60)/5.0, (SCREEN_WIDTH-60)/5.0)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:img.path]];
            [_bgView addSubview:imageV];
        }
        
    }
    height += (SCREEN_WIDTH-60)/5.0;
    height += 10;
    _line1.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 0.5);
    
    height += 0.5;
    
    _stateView = [[RunOrderStateView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 87)];
    _stateView.paymentType = item.payment_method;
    _stateView.state = item.state;
    _stateView.payment = item.pay_state;
    _stateView.exp_name = item.exp_name;
    

    [_bgView addSubview:_stateView];
    
    height += 87;
    
    _line2.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 0.5);
    
    height += 0.5;
    
    _detailButton = [CreateButton initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 45) title:NSLocalizedString(kLookDetail, nil) titleColor:ButtonColor font:[UIFont systemFontOfSize:15] target:self action:@selector(detailButtonClick:)];
    [_bgView addSubview:_detailButton];
    
    height += 45;
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    
}

+ (CGFloat)cellHeightWithModel:(RunOrderItem *)item{
    CGFloat height = 59;
    height += 9;
    CGFloat remarkH = [StringHeight heightFromString:item.remark withFont:15 constraintToWidth:SCREEN_WIDTH-20];
    height += remarkH;
    height += 10;
    height += 87;

    height += (SCREEN_WIDTH-60)/5.0;
    height += 11;
    height += 55;

    return height;
}

- (void)detailButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(runOrderDetailButtonClickWithModel:)]) {
        [self.delegate runOrderDetailButtonClickWithModel:_item];
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
