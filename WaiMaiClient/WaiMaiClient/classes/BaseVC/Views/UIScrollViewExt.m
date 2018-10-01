//
//  UIScrollViewExt.m
//  PolicePatrol
//
//  Created by chasen on 2017/10/25.
//  Copyright © 2017年 Chason. All rights reserved.
//

#import "UIScrollViewExt.h"

@implementation UIScrollViewExt

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delaysContentTouches=NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delaysContentTouches=NO;
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if ([view isKindOfClass:[UIButton class]]){
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}
@end
