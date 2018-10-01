//
//  UILabel+extension.m
//  Modao
//
//  Created by chason on 16/3/3.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UILabel+extension.h"
#import <objc/runtime.h>
@implementation UILabel (extension)

-(void)setContentText:(NSString *)contentText{
    if (contentText==nil) {
        contentText=@"";
    }
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.paragraphSpacing=7.5f;//段间距
    paragraphStyle.lineSpacing=3.5f;//行间距
//    paragraphStyle.lineHeightMultiple = 1.50f;
//    paragraphStyle.maximumLineHeight = 20.f;
//    paragraphStyle.minimumLineHeight = 10.f;
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSMutableDictionary *textAttributes =[[NSMutableDictionary alloc]init];
    [textAttributes setObject:@(1.0) forKey:NSKernAttributeName];//字间距
    [textAttributes setObject:self.font forKey:NSFontAttributeName];
    [textAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    [textAttributes setObject:self.textColor forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:contentText attributes:textAttributes];
    self.attributedText = attributedString;
}

-(NSString *)contentText{
    return self.attributedText.string;
}

-(void)sizeThatFitsWithWidth{
    CGSize size = [self sizeThatFits:CGSizeMake(self.width, NSIntegerMax)];
    self.height=size.height;
}

-(void)sizeThatFitsWithHeight{
    CGSize size = [self sizeThatFits:CGSizeMake(NSIntegerMax, self.height)];
    self.width=size.width;
}

-(void)sizeThatFitsUnderWidth{
    CGSize size=[self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    if (size.width>self.width) {
        [self sizeThatFitsWithWidth];
    }
    else{
        [self sizeToFit];
    }
}

-(void)sizeThatFitsUnderHeight{
    CGSize size=[self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    if (size.height>self.height) {
        [self sizeThatFitsWithHeight];
    }
    else{
        [self sizeToFit];
    }
}

#pragma mark - Change  方法
- (void)changeFont:(UIFont *)textFont changeText:(NSString *)text{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [attributedString addAttribute:NSFontAttributeName value:textFont range:range];
    }
    self.attributedText = attributedString;
}

- (void)changeColor:(UIColor *)textColor changeText:(NSString *)text {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    }
    self.attributedText = attributedString;
}

- (void)changeFont:(UIFont *)textFont changeColor:(UIColor *)textColor changeText:(NSString *)text {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [attributedString addAttributes:@{NSForegroundColorAttributeName:textColor,NSFontAttributeName:textFont} range:range];
    }
    self.attributedText = attributedString;
}

#pragma mark - CopyText 方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}

//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

- (void)setIsCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)isCopyable {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}


@end
