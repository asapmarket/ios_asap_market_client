//
//  UIViewController+TopBar.m
//  Ruyue
//
//  Created by lyywhg on 15/6/2.
//  Copyright (c) 2015年 ADean. All rights reserved.
//

#import "UIViewController+extension.h"
#import <objc/runtime.h>
#import "NSString+extension.h"

static const void *kTopBarViewObjectKey;
static const void *kTopCustomViewObjectKey;
static const void *kTopBottomLineObjectKey;
static const void *kBackButtonObjectKey;
static const void *kRightButtonObjectKey;
static const void *kTopTitleLabelObjectKey;

@implementation UIViewController (extension)

#pragma mark - Custom Methods

- (void)setTopBarTitle:(NSString*)title{
    if (self.navigationController.viewControllers.count > 1) {
        [self.topBarView addSubview:self.backButton];
//        [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    }
    self.topTitleLabel.text = title;
}

-(void)setTopBarCustom:(UIView *)customView{
    [self.topBarView addSubview:customView];
    objc_setAssociatedObject(self, &kTopCustomViewObjectKey, customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    customView.center=CGPointMake(self.topBarView.width/2, isIPhoneX?64:20 + (self.topBarView.height-(isIPhoneX?44:20))/2);
}

- (void)setTopBarTitle:(NSString*)title leftTextButton:(NSString *)text{
    [self.topBarView addSubview:self.backButton];
    CGFloat width = [UIViewController getStringWidth:text height:34 font:[UIFont font16]].width;
    if (width < 34){
        width = 34;
    }
    self.backButton.frame = CGRectMake(10, (isIPhoneX?44:20)+5, width, 34);
    [self.backButton setTitle:text forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont font16];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.topTitleLabel.text = title;
}

- (void)setTopBarTitle:(NSString*)title leftTextButton:(NSString *)text needLeftImage:(BOOL)needLeftImage{
    if (needLeftImage) {
        [self setTopBarTitle:title];
    }
    [self.topBarView addSubview:self.backButton];
    CGFloat width = [UIViewController getStringWidth:text height:34 font:[UIFont font16]].width;
    if (width < 34)
    {
        width = 34;
    }
    self.backButton.frame = CGRectMake(20, (isIPhoneX?44:20)+5, width+10, 34);
    [self.backButton setTitle:text forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont font16];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.topTitleLabel.text = title;
}

- (void)setTopBarTitle:(NSString*)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImgName{
    [self setTopBarTitle:title];
    UIImage *left=[UIImage imageNamed:leftImage];
    self.backButton.imageRect=CGRectMake(12, (self.backButton.height-left.size.height)/2, left.size.width, left.size.height);
    [self.backButton setTitle:title forState:UIControlStateNormal];
    [self.backButton setImage:left forState:UIControlStateNormal];
    [self.backButton setImage:left forState:UIControlStateHighlighted];
    UIImage *right=[UIImage imageNamed:rightImgName];
    [self.rightButton setImage:right forState:UIControlStateNormal];
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake((self.rightButton.height-right.size.height)/2.0, (self.rightButton.width-right.size.width-12), (self.rightButton.height-right.size.height)/2.0, 12);
    [self.topBarView addSubview:self.rightButton];
}

- (void)setTopBarTitle:(NSString*)title rightImage:(NSString*)imgName{
    [self setTopBarTitle:title];
    [self.rightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
//    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.topBarView addSubview:self.rightButton];
}

- (void)setTopBarTitle:(NSString*)title rightText:(NSString*)text{
    [self setTopBarTitle:title];
    CGFloat width = [UIViewController getStringWidth:text height:44 font:[UIFont font17]].width;
    if (width < 44)
    {
        width = 44;
    }
    self.rightButton.frame = CGRectMake(kScreenWidth-width-10, (isIPhoneX?44:20), width, 44);
    [self.rightButton setTitle:text forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont font16];
    [self.topBarView addSubview:self.rightButton];
}

- (void)leftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction{
    
}

#pragma mark
#pragma mark Init & Add
- (UIView *)topBarView{
    UIView *topBarView = objc_getAssociatedObject(self, &kTopBarViewObjectKey);
    if (!topBarView){
        topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (isIPhoneX?44:20)+44)];
        [topBarView addSubview:self.topTitleLabel];
        topBarView.backgroundColor = [UIColor navigationBarColor];
        [self.view addSubview:topBarView];
        [topBarView addSubview:self.topBottomLine];
        objc_setAssociatedObject(self, &kTopBarViewObjectKey, topBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return topBarView;
}

-(void)setTopBarView:(UIView *)topBarView{
    objc_setAssociatedObject(self, &kTopBarViewObjectKey, topBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)customView{
    UIView *customView = objc_getAssociatedObject(self, &kTopCustomViewObjectKey);
    return customView;
}

- (UIView *)topBottomLine{
    UIView *topBottomLine = objc_getAssociatedObject(self, &kTopBottomLineObjectKey);
    if (!topBottomLine){
        topBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, (isIPhoneX?44:20)+44-0.5, kScreenWidth, 0.5)];
//        topBottomLine.backgroundColor = ADeanRGBCOLOR(198, 198, 198);
        // lcj 204 217 242
        topBottomLine.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
        objc_setAssociatedObject(self, &kTopBottomLineObjectKey, topBottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return topBottomLine;
}

- (void)setTopBottomLine:(UIView *)topBottomLine{
    objc_setAssociatedObject(self, &kTopBottomLineObjectKey, topBottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)topTitleLabel{
    UILabel *topTitleLabel = objc_getAssociatedObject(self, &kTopTitleLabelObjectKey);
    if (!topTitleLabel)
    {
        topTitleLabel = [[UILabel alloc] init];
        topTitleLabel.frame = CGRectMake((kScreenWidth - 150)/2, (isIPhoneX?44:20)+13.5, 150, 17);
        topTitleLabel.textAlignment = NSTextAlignmentCenter;
        topTitleLabel.textColor = [UIColor navigationItemColor];
        topTitleLabel.font = [UIFont font17];
        topTitleLabel.backgroundColor = [UIColor clearColor];
        objc_setAssociatedObject(self, &kTopTitleLabelObjectKey, topTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return topTitleLabel;
}

- (void)setTopTitleLabel:(UILabel *)topTitleLabel{
    objc_setAssociatedObject(self, &kTopTitleLabelObjectKey, topTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButtonCustom *)backButton{
    UIButtonCustom *backButton = objc_getAssociatedObject(self, &kBackButtonObjectKey);
    if (!backButton)
    {
        backButton = [[UIButtonCustom alloc]initWithFrame:CGRectMake(0, (isIPhoneX?44:20), 88, 44)];
        backButton.imageRect=CGRectMake(20, (backButton.height-18)/2, 10, 18);
        backButton.titleRect=CGRectMake(35, 0, 88-35, 44);
        backButton.titleLabel.font=[UIFont font16];
        [backButton setTitleColor:[UIColor navigationItemColor] forState:UIControlStateNormal];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, &kBackButtonObjectKey, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backButton;
}

- (void)setBackButton:(UIButton *)backButton{
    objc_setAssociatedObject(self, &kBackButtonObjectKey, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)rightButton{
    UIButton *rightButton = objc_getAssociatedObject(self, &kRightButtonObjectKey);
    if (!rightButton)
    {
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(kScreenWidth-44, (isIPhoneX?44:20), 44, 44);
        rightButton.titleLabel.font = [UIFont font15];
        [rightButton setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, &kRightButtonObjectKey, rightButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return rightButton;
}

- (void)setRightButton:(UIButton *)rightButton{
    objc_setAssociatedObject(self, &kRightButtonObjectKey, rightButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - String 方法

+ (CGSize)getStringHeight:(NSString *)stringText width:(NSInteger)sWidth font:(UIFont *)theFont{
    if (theFont == nil){
        theFont = [UIFont font15];
    }
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:theFont, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect rectName = [stringText boundingRectWithSize:CGSizeMake(sWidth, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGSize sizeName;
        sizeName.width = ceil(rectName.size.width);
        sizeName.height = ceil(rectName.size.height);
        return sizeName;
    }
    return CGSizeZero;
}

+ (CGSize)getStringWidth:(NSString *)stringText height:(NSInteger)sHeight font:(UIFont *)theFont{
    if (theFont == nil){
        theFont = [UIFont font15];
    }
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:theFont, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGRect rectName = [stringText boundingRectWithSize:CGSizeMake(999, sHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGSize sizeName;
        sizeName.width = ceil(rectName.size.width);
        sizeName.height = ceil(rectName.size.height);
        return sizeName;
    }
    return CGSizeZero;
}

+ (CGSize)getStringSize:(NSString *)stringText font:(UIFont *)theFont{
    if (theFont == nil){
        theFont = [UIFont font15];
    }
    if ([stringText respondsToSelector:@selector(sizeWithAttributes:)]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:theFont, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGSize sizeName = [stringText sizeWithAttributes:attributes ];
        return sizeName;
    }
    return CGSizeZero;
}

@end
