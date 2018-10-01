//
//  PageControl.m
//  whcy
//
//  Created by 王 on 2018/4/8.
//  Copyright © 2018年 王. All rights reserved.
//

#import "PageControl.h"

@interface PageControl ()

/** currentDot */
@property (nonatomic ,strong) UIImageView * currentDot;

/** dots */
@property (nonatomic ,strong) NSMutableArray * dots;

/** count */
@property (nonatomic ,assign) NSInteger count;

@end

@implementation PageControl

- (instancetype)initWithFrame:(CGRect)frame andDotCount:(NSInteger)count{
    self.count = count;
    CGRect rect = frame;
    rect.size = CGSizeMake(14 * (count + 1), 2.5);
    return [self initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.normalDotColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.selectedDotColor = RGB(250, 44, 44);
        self.dots = [NSMutableArray array];
        self.currentIndex = 0;
        [self setupUI];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)index{
    
    if (index == self.currentIndex || index < 0 || index >= self.count) {
        return;
    }
    
    UIView * currentDot = self.currentDot;
    UIView * exchangeDot = [self.dots objectAtIndex:index];
    if (index > self.currentIndex) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint currentPoint = currentDot.center;
            currentDot.center = CGPointMake(exchangeDot.center.x - 4, exchangeDot.center.y);
            for (NSInteger i = self.currentIndex + 1; i <= index; i ++) {
                UIView * dot = [self.dots objectAtIndex:i];
                dot.center = CGPointMake(dot.center.x - 22, currentPoint.y);
            }
        }];
        
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint currentPoint = currentDot.center;
            currentDot.center = CGPointMake(exchangeDot.center.x + 4, exchangeDot.center.y);
            for (NSInteger i = index; i < self.currentIndex; i ++) {
                UIView * dot = [self.dots objectAtIndex:i];
                dot.center = CGPointMake(dot.center.x + 22, currentPoint.y);
            }
        }];
    }
    
    [self.dots removeObjectAtIndex:self.currentIndex];
    [self.dots insertObject:self.currentDot atIndex:index];
    self.currentIndex = index;
}

- (void)setupUI{
    
    // 添加选中的Dot
    [self.dots addObject:self.currentDot];
    [self addSubview:self.currentDot];
    
    // 创建普通Dot
    for (int i = 0; i < self.count - 1; i ++) {
        CGFloat X = 14 * (i + 2);
        //Dots
        UIImageView * dot = [[UIImageView alloc]initWithFrame:CGRectMake(X, 1, 7, 2.5)];
        dot.tag = i;
        dot.layer.masksToBounds = YES;
        dot.backgroundColor = self.normalDotColor;
        [self addSubview:dot];
        [self.dots addObject:dot];
    }
}

- (UIView *)currentDot{
    if (!_currentDot) {
        _currentDot = [[UIImageView alloc]initWithFrame:CGRectMake(6, 1, 14, 2.5)];
        _currentDot.tag = 8;
        _currentDot.backgroundColor = self.selectedDotColor;
        _currentDot.layer.masksToBounds = YES;
    }
    return _currentDot;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
