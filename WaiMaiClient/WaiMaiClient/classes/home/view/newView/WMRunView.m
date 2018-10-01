//
//  WMRunView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMRunView.h"

@interface WMRunView ()

@property (nonatomic, strong) UIButton *runButton;

@end

@implementation WMRunView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexStringToColor:@"#2196f3"];
        
        _runButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runButton.backgroundColor = [UIColor hexStringToColor:@"#2196f3"];
        [_runButton setImage:[UIImage imageNamed:@"PersonalizedOrder"] forState:UIControlStateNormal];
        _runButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_runButton setTitle:NSLocalizedString(@"PersonalizedOrder", nil) forState:UIControlStateNormal];
        [_runButton addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_runButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _runButton.frame = self.bounds;
}

- (void)onTap{
    if (self.runViewDidTouchBlock) {
        self.runViewDidTouchBlock(self);
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
