//
//  OrderSegmentView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/15.
//  Copyright © 2018年 王. All rights reserved.
//

#import "OrderSegmentView.h"

@interface OrderSegmentView ()

@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) UIButton *runButton;

@end

@implementation OrderSegmentView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2.0, 44);
    _orderButton.backgroundColor = [UIColor whiteColor];
    _orderButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_orderButton setTitle:NSLocalizedString(@"DeliveryOrders", nil) forState:UIControlStateNormal];
    [_orderButton setTitleColor:[UIColor hexStringToColor:@"#2196f3"] forState:UIControlStateSelected];
    [_orderButton setTitleColor:[UIColor hexStringToColor:@"#4d4d4d"] forState:UIControlStateNormal];
    _orderButton.selected = YES;
    [_orderButton addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_orderButton];
    
    _runButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _runButton.frame = CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, 44);
    _runButton.backgroundColor = [UIColor whiteColor];
    _runButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_runButton setTitle:NSLocalizedString(@"RunningErrandsOrders", nil) forState:UIControlStateNormal];
    [_runButton setTitleColor:[UIColor hexStringToColor:@"#2196f3"] forState:UIControlStateSelected];
    [_runButton setTitleColor:[UIColor hexStringToColor:@"#4d4d4d"] forState:UIControlStateNormal];
    [_runButton addTarget:self action:@selector(runButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_runButton];
    
    _orderButton.selected = YES;
    _runButton.selected = NO;
    
}

- (void)orderButtonClick:(UIButton *)btn{
    if (btn.isSelected){
        return;
    }
    btn.selected = YES;
    _runButton.selected = NO;
    if (self.oderButtonBlock) {
        self.oderButtonBlock(btn);
    }
}

- (void)runButtonClick:(UIButton *)btn{
    if (btn.isSelected){
        return;
    }
    btn.selected = YES;
    _orderButton.selected = NO;
    if (self.runButtonBlock) {
        self.runButtonBlock(btn);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
