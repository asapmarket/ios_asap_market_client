//
//  OrderStateView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderStateView.h"

#define space (50)
#define ViewW ((SCREEN_WIDTH-100)/4.0)
#define Circle_y ()

@interface OrderStateView ()

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIImageView *imageView4;
@property (nonatomic, strong) UIImageView *imageView5;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation OrderStateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _line1 = [self lineViewWithIndex:0];
        _line2 = [self lineViewWithIndex:1];
        _line3 = [self lineViewWithIndex:2];
        _line4 = [self lineViewWithIndex:3];

        _imageView1 = [self imageViewWithIndex:0];
        _imageView2 = [self imageViewWithIndex:1];
        _imageView3 = [self imageViewWithIndex:2];
        _imageView4 = [self imageViewWithIndex:3];
        _imageView5 = [self imageViewWithIndex:4];

        
        _titleArray = @[NSLocalizedString(kOrderSuccess, nil),NSLocalizedString(kOrder, nil),NSLocalizedString(kTake, nil), NSLocalizedString(kOnRoad, nil), NSLocalizedString(kOrderEnd, nil)];
        _label1 = [self labelWithIndex:0];
        _label2 = [self labelWithIndex:1];
        _label3 = [self labelWithIndex:2];
        _label4 = [self labelWithIndex:3];
        _label5 = [self labelWithIndex:4];
        
    }
    return self;
}


- (void)setType:(NSInteger)type{
   
}

- (void)setState:(NSString *)state{
    _state = state;
    if ([state isEqualToString:@"0"]) {
//        _line1.backgroundColor = ButtonColor;
        [_imageView1 setImage:[UIImage imageNamed:@"circle_blue"]];
    }else if ([state isEqualToString:@"1"]){
        _line1.backgroundColor = ButtonColor;
        [_imageView1 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView2 setImage:[UIImage imageNamed:@"circle_blue"]];
    }else if ([state isEqualToString:@"2"] || [state isEqualToString:@"8"]){
        _line1.backgroundColor = ButtonColor;
        _line2.backgroundColor = ButtonColor;
        [_imageView1 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView2 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView3 setImage:[UIImage imageNamed:@"circle_blue"]];
    }else if ([state isEqualToString:@"3"] ){
        _line1.backgroundColor = ButtonColor;
        _line2.backgroundColor = ButtonColor;
        _line3.backgroundColor = ButtonColor;
        [_imageView1 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView2 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView3 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView4 setImage:[UIImage imageNamed:@"circle_blue"]];
    }else{
        _line1.backgroundColor = ButtonColor;
        _line2.backgroundColor = ButtonColor;
        _line3.backgroundColor = ButtonColor;
        _line4.backgroundColor = ButtonColor;
        [_imageView1 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView2 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView3 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView4 setImage:[UIImage imageNamed:@"circle_blue"]];
        [_imageView5 setImage:[UIImage imageNamed:@"circle_blue"]];
    }
}

- (void)setExp_name:(NSString *)exp_name{
    _exp_name = exp_name;
    UILabel *label = (UILabel *) [self viewWithTag:10000];
    if (_exp_name) {
        label.text = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(kCourier, nil),exp_name,NSLocalizedString(kReceiveOrder, nil)];
    }else{
        label.text = NSLocalizedString(@"NoOrders", nil);
    }
}

- (UIView *)lineViewWithIndex:(NSInteger)index{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(space+ViewW*index, 35, ViewW, 2)];
    view.backgroundColor = [UIColor hexStringToColor:@"#999999"];
    [self addSubview:view];
    
    return view;
}

- (UIImageView *)imageViewWithIndex:(NSInteger)index{
    CGFloat x = space;
    if (index == 0) {
        x = space-6;
    }else{
        x = space-6+ViewW*index;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 30, 12, 12.5)];
    imageView.image = [UIImage imageNamed:@"cirle_gray"];
    [self addSubview:imageView];
    return imageView;
}

- (UILabel *)labelWithIndex:(NSInteger)index{
    UILabel *label = [[UILabel alloc] init];
    if (index == 1) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(space, 6, ViewW*2, 15)];
        label.text = nil;
        label.tag = 10000;
    }else{
        label = [[UILabel alloc] initWithFrame:CGRectMake(10+(SCREEN_WIDTH-20)/5.0*index, 56, (SCREEN_WIDTH-20)/5.0, 15)];
        label.text = _titleArray[index];
    }
    
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor hexStringToColor:@"#999999"];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end