//
//  UITableViewExt.m
//  ProjectFramework
//
//  Created by Chason on 16/3/2.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "UITableViewExt.h"

@implementation UITableViewExt

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
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
