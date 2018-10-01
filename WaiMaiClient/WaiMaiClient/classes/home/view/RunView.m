//
//  RunView.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/14.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunView.h"

@interface RunView ()

@property (nonatomic, strong) UIButton *runButton;


@end

@implementation RunView

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor hexStringToColor:@"#2196f3"];
        
        _runButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runButton.backgroundColor = [UIColor hexStringToColor:@"#2196f3"];
        [_runButton setImage:[UIImage imageNamed:@"PersonalizedOrder"] forState:UIControlStateNormal];
        [_runButton setImage:[UIImage imageNamed:@"PersonalizedOrder"] forState:UIControlStateHighlighted];
        _runButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_runButton setTitle:NSLocalizedString(@"PersonalizedOrder", nil) forState:UIControlStateNormal];
        [self addSubview:_runButton];
        [_runButton addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
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
