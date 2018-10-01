//
//  RunAddrView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/26.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunAddrView.h"

@implementation RunAddrView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.width, 0.5)];
        _line1.backgroundColor = [UIColor hexStringToColor:@"#c2c2c2"];
        [self addSubview:_line1];
        _leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.height-17)/2, 15, 17)];
        _leftIcon.image = [UIImage imageNamed:@"location"];
        [self addSubview:_leftIcon];
        _titleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _titleLabel.frame = CGRectMake(45, 0.5, self.width-55, self.height-1);
        _titleLabel.text = NSLocalizedString(kAhippingAddress, nil);
        [self addSubview:_titleLabel];
        _rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-6, (self.height-11.5)/2.0, 6, 11.5)];
        _rightIcon.image = [UIImage imageNamed:@"right_icon"];
        [self addSubview:_rightIcon];
        _line2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.height-0.5, self.width, 0.5)];
        _line2.backgroundColor = [UIColor hexStringToColor:@"#c2c2c2"];
        [self addSubview:_line2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)addressClick{
    if (self.addressItemBlock) {
        self.addressItemBlock(_titleLabel.text);
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
