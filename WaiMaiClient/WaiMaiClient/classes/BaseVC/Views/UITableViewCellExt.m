//
//  UITableViewCellExt.m
//  ProjectFramework
//
//  Created by Chason on 16/3/2.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "UITableViewCellExt.h"
#import "UILine.h"

@implementation UITableViewCellExt

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _separatorLine=[[UILine alloc]initWithFrame:CGRectZero];
        [self addSubview:_separatorLine];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _separatorLine.frame = CGRectMake(20, self.height-0.5, kScreenWidth-40, 0.5);
    [self bringSubviewToFront:_separatorLine];
}

-(void)initView{
    
}

+(CGFloat)cellHeight{
    return 100;
}

@end
