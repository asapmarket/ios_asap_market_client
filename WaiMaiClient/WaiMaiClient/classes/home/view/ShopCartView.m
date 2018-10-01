//
//  ShopCartView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopCartView.h"

@interface ShopCartView (){
    CGPoint startPoint;
}

@property (nonatomic, strong) UIView *countView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation ShopCartView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageV.image = [UIImage imageNamed:@"shopCart"];
        _imageV.userInteractionEnabled = YES;
        [self addSubview:_imageV];
        
        _countView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 19, 19)];
        _countView.backgroundColor = [UIColor redColor];
        _countView.layer.cornerRadius = 9.5;
        [self addSubview:_countView];
        [self bringSubviewToFront:_countView];
        _countView.hidden = YES;
        
        _countLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter] ;
        _countLabel.frame = _countView.bounds;
        [_countView addSubview:_countLabel];
        
    }
    return self;
}

- (void)setCount:(int)count{
    if (count <= 0) {
        _countView.hidden = YES;
    }else if (count < 99){
        _countView.hidden = NO;
        _countLabel.text = [NSString stringWithFormat:@"%d",count];
        _countView.frame = CGRectMake(0, 5, 19, 19);
        _countLabel.frame = _countView.bounds;
    }else{
        _countLabel.text = [NSString stringWithFormat:@"99+"];
        _countView.frame = CGRectMake(0, 5, 25, 19);
        _countLabel.frame = _countView.bounds;
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
