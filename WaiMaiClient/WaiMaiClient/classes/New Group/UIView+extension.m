//
//  UIView+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//
#import "UIView+extension.h"
#import "UILine.h"

@implementation UIView (extension)
//top
-(void)setTop:(CGFloat)top{
    CGRect frame=self.frame;
    if (self.frame.origin.y==top) {
        return;
    }
    frame.origin=CGPointMake(frame.origin.x, top);
    self.frame=frame;
}

-(CGFloat)top{
    return self.frame.origin.y;
}

//bottom
-(void)setBottom:(CGFloat)bottom{
    CGRect frame=self.frame;
    if (self.frame.origin.y+self.frame.size.height==bottom) {
        return;
    }
    frame.origin=CGPointMake(frame.origin.x, bottom-self.frame.size.height);
    self.frame=frame;
}

-(CGFloat)bottom{
    return self.frame.origin.y+self.frame.size.height;
}

//left
-(void)setLeft:(CGFloat)left{
    CGRect frame=self.frame;
    if (self.frame.origin.x==left) {
        return;
    }
    frame.origin=CGPointMake(left,self.frame.origin.y);
    self.frame=frame;
}

-(CGFloat)left{
    return self.frame.origin.x;
}

//right
-(void)setRight:(CGFloat)right{
    CGRect frame=self.frame;
    if (self.frame.origin.x+self.frame.size.width==right) {
        return;
    }
    frame.origin=CGPointMake(right-self.frame.size.width,self.frame.origin.y);
    self.frame=frame;
}

-(CGFloat)right{
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    if (center.x == centerX) {
        return;
    }
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
   
    CGPoint center = self.center;
    if (center.y == centerY) {
        return;
    }
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

//x
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    if (self.frame.origin.x==x) {
        return;
    }
    frame.origin=CGPointMake(x, frame.origin.y);
    self.frame=frame;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

//y
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    if (self.frame.origin.y==y) {
        return;
    }
    frame.origin=CGPointMake(frame.origin.x, y);
    self.frame=frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

//width
-(void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    if (self.frame.size.width==width) {
        return;
    }
    frame.size=CGSizeMake(width, frame.size.height);
    self.frame=frame;
}

-(CGFloat)width{
    return self.bounds.size.width;
}

//height
-(void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    if (self.frame.size.height==height) {
        return;
    }
    frame.size=CGSizeMake(frame.size.width, height);
    self.frame=frame;
}

-(CGFloat)height{
    return self.bounds.size.height;
}

//size
-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    if (CGSizeEqualToSize(frame.size, size)) {
        return;
    }
    frame.size=size;
    self.frame=frame;
}

-(CGSize)size{
    return self.bounds.size;
}

//leftTop
-(void)setLeftTop:(CGPoint)leftTop{
    if (CGPointEqualToPoint(self.frame.origin, leftTop)) {
        return;
    }
    CGRect frame=self.frame;
    frame.origin=leftTop;
    self.frame=frame;
}

-(CGPoint)leftTop{
    return self.frame.origin;
}

//leftCenter
-(void)setLeftCenter:(CGPoint)leftCenter{
    CGPoint leftTop=self.leftTop;
    leftTop.x=leftCenter.x;
    leftTop.y=leftCenter.y-self.height/2.0;
    [self setLeftTop:leftTop];
}

-(CGPoint)leftCenter{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y+self.height/2.0);
}

//leftBottom
-(void)setLeftBottom:(CGPoint)leftBottom{
    CGPoint leftTop=self.leftTop;
    leftTop.x=leftBottom.x;
    leftTop.y=leftBottom.y-self.height;
    [self setLeftTop:leftTop];
}

-(CGPoint)leftBottom{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y+self.height);
}

//topCenter
-(void)setTopCenter:(CGPoint)topCenter{
    CGPoint leftTop=self.leftTop;
    leftTop.x=topCenter.x-self.width/2.0;
    leftTop.y=topCenter.y;
    [self setLeftTop:leftTop];
}

-(CGPoint)topCenter{
    return CGPointMake(self.frame.origin.x+self.width/2.0, self.frame.origin.y);
}

//bottomCenter
-(void)setBottomCenter:(CGPoint)bottomCenter{
    CGPoint leftTop=self.leftTop;
    leftTop.x=bottomCenter.x-self.width/2.0;
    leftTop.y=bottomCenter.y-self.height;
    [self setLeftTop:leftTop];
}

-(CGPoint)bottomCenter{
    return CGPointMake(self.frame.origin.x+self.width/2.0, self.frame.origin.y+self.height);
}

//rightTop
-(void)setRightTop:(CGPoint)rightTop{
    CGPoint leftTop=self.leftTop;
    leftTop.x=rightTop.x-self.width;
    leftTop.y=rightTop.y;
    [self setLeftTop:leftTop];
}

-(CGPoint)rightTop{
    return CGPointMake(self.frame.origin.x+self.width, self.frame.origin.y);
}

//rightCenter
-(void)setRightCenter:(CGPoint)rightCenter{
    CGPoint leftTop=self.leftTop;
    leftTop.x=rightCenter.x-self.width;
    leftTop.y=rightCenter.y-self.height/2.0;
    [self setLeftTop:leftTop];
}

-(CGPoint)rightCenter{
    return CGPointMake(self.frame.origin.x+self.width, self.frame.origin.y+self.height/2.0);
}

//rightBottom
-(void)setRightBottom:(CGPoint)rightBottom{
    CGPoint leftTop=self.leftTop;
    leftTop.x=rightBottom.x-self.width;
    leftTop.y=rightBottom.y-self.height;
    [self setLeftTop:leftTop];
}

-(CGPoint)rightBottom{
    return CGPointMake(self.frame.origin.x+self.width, self.frame.origin.y+self.height);
}

//Top的圆角
- (void)drawBorderWithTopCorner:(UIView *)view withCornerRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

//Bottom的圆角
- (void)drawBorderWithBottomCorner:(UIView *)view withCornerRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

//drawBorder
-(void)drawBorder:(CGFloat)width color:(UIColor *)color{
    if (color==nil) {
        color=[UIColor redColor];
    }
    else if (width==0){
        width=1.0;
    }
    self.layer.borderWidth =width;
    self.layer.borderColor=color.CGColor;
}

//debugWithColor
-(void)debugWithColor:(UIColor *)color{
    [self drawBorder:1.0 color:color];
}

-(UILabel *)addLable:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    UILabel *lable=[[UILabel alloc]init];
    lable.text=text;
    lable.font=font;
    lable.textColor=color;
    [lable sizeToFit];
    [self addSubview:lable];
    return lable;
}

-(UILine *)addLine:(CGFloat)width color:(UIColor *)color{
    if (width<=0) {
        width=1.0;
    }
    UILine *line=[[UILine alloc]initWithFrame:CGRectMake(0, 0, self.width, width)];
    if (color!=nil) {
        line.backgroundColor=color;
    }
    line.leftBottom=CGPointMake(0, self.height);
    [self addSubview:line];
    return line;
}

- (void)drawShadowWithColor:(UIColor *)color{
     [self drawShadow:color offset:CGSizeMake(0,5) radius:4.0f];
}

-(void)drawShadowWithSize:(CGSize)offset{
    self.layer.shadowColor=[UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.layer.shadowOffset=offset;
    self.layer.shadowOpacity=0.5f;
    self.layer.shadowRadius = 4.0f;
}

- (void)drawShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"\nclass:%@ frame:%@\n",NSStringFromClass(self.class),NSStringFromCGRect(self.frame)];
}

-(id)copyWithZone:(NSZone *)zone{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}


@end
