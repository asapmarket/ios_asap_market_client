//
//  OrderDetailHeaderCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderDetailHeaderCell.h"
#import "OrderStateView.h"
#import "StringHeight.h"
#import "OrderSectionView.h"
#import "RunOrderStateView.h"

@interface OrderDetailHeaderCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) OrderStateView *stateView;
@property (nonatomic, strong) OrderSectionView *sectionView;
@property (nonatomic, strong) RunOrderStateView *runStateView;


@end

@implementation OrderDetailHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _line = [[UIView alloc] initWithFrame:CGRectMake(10, 134.5, SCREEN_WIDTH-20, 0.5)];
        _line.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
        [self addSubview:_line];
    }
    return self;
}

- (void)setType:(NSInteger)type{
    _type = type;
}

- (void)setBaseModel:(OrderDetailBaseModel *)baseModel{
    _sectionView = [[OrderSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
    _sectionView.order_id = baseModel.order_id;
    [self addSubview:_sectionView];
    
    _stateView = [[OrderStateView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 76)];
    _stateView.state = baseModel.state;
    _stateView.exp_name = baseModel.exp_name;
    [self addSubview:_stateView];

}

- (void)setRunModel:(RunOrderDetailModel *)runModel{
    _sectionView = [[OrderSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
    _sectionView.order_id = runModel.order_id;
    [self addSubview:_sectionView];
    
    _runStateView = [[RunOrderStateView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 76)];
    _runStateView.paymentType = runModel.payment_method;
    _runStateView.state = runModel.state;
    _runStateView.payment = runModel.pay_state;
    _runStateView.exp_name = runModel.exp_name;
    [self addSubview:_runStateView];


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
