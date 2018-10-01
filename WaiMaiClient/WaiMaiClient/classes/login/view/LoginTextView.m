//
//  LoginTextView.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LoginTextView.h"

@interface LoginTextView (){
    
}

@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation LoginTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(TableBorder, frame.size.height-0.5, SCREEN_WIDTH-2*TableBorder, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self addSubview:line];
        
        
    }
    return self;
}

- (void)updateViewWithIsLabel:(BOOL)isLabel{
    CGFloat y = 58;
    if (isLabel) {
        y = 50;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(y, 0, 30, 45)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = @"+1";
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self addSubview:label];
        y += 30;
    }
    _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(y, 6, SCREEN_WIDTH-70, 35)];
    [_myTextField setFont:[UIFont systemFontOfSize:15]];
    _myTextField.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_myTextField];
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _leftImageView.image = [UIImage imageNamed:imageName];
}

- (void)setImageViewWithSize:(CGSize)size{
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, (self.bounds.size.height-size.height)/2.0, size.width, size.height)];
    [self addSubview:_leftImageView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
