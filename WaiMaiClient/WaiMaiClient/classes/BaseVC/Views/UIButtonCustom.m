//
//  RectButton.m
//  PointsLife
//
//  Created by Chason on 16/3/9.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "UIButtonCustom.h"

@implementation UIButtonCustom

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    if (backgroundColor) {
        self.clipsToBounds=YES;
        UIImage *backgroundImage=[UIImage imageWithColor:backgroundColor imageSize:self.size];
        [self setBackgroundImage:backgroundImage forState:state];
    }
}

-(void)setImageRect:(CGRect)imageRect{
    _imageRect=imageRect;
    if (isIOS7_9) {
        [self setNeedsLayout];
    }
}

-(void)setTitleRect:(CGRect)titleRect{
    _titleRect=titleRect;
    if (isIOS7_9) {
        [self setNeedsLayout];
    }
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return self.imageRect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return self.titleRect;
}

@end
