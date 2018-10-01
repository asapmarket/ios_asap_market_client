//
//  UITextViewExt.m
//  Government
//
//  Created by Government on 16/9/13.
//  Copyright © 2016年 Government. All rights reserved.
//

#import "UITextViewExt.h"

@interface UITextViewExt ()
@property(nonatomic,strong)UILabel *placeholderLabel;
@end

@implementation UITextViewExt


-(instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        self.textColor=[UIColor text3];
        self.placeholderColor=[UIColor text9];
        _placeholderLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width-10, self.height)];
        _placeholderLabel.numberOfLines=0;
        [self addSubview:_placeholderLabel];
        self.font=[UIFont font16];
        NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing=7.0f;
        self.typingAttributes=@{NSParagraphStyleAttributeName:paragraphStyle};
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        self.textColor=[UIColor text3];
        self.placeholderColor=[UIColor text6];
        _placeholderLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width-10, self.height)];
        _placeholderLabel.numberOfLines=0;
        [self addSubview:_placeholderLabel];
        self.font=[UIFont font16];
        NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing=7.0f;
        self.typingAttributes=@{NSParagraphStyleAttributeName:paragraphStyle};
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder=placeholder;
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing=7.0f;
    NSAttributedString *attributedString=[[NSAttributedString alloc]initWithString:placeholder attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont font16],NSForegroundColorAttributeName:self.placeholderColor}];
    _placeholderLabel.attributedText=attributedString;
    [_placeholderLabel sizeToFit];
    _placeholderLabel.leftTop=CGPointMake(5, 8);
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor=placeholderColor;
    _placeholderLabel.textColor=placeholderColor;
}

-(void)textChange:(NSNotification *)sender{
    if (self.placeholder.length<=0) {
        return;
    }
    if (self.text.length<=0) {
        self.placeholderLabel.hidden=NO;
    }
    else{
        self.placeholderLabel.hidden=YES;
    }
}

-(void)setText:(NSString *)text{
    [super setText:text];
    if (self.placeholder.length<=0) {
        return;
    }
    if (self.text.length<=0) {
        self.placeholderLabel.hidden=NO;
    }
    else{
        self.placeholderLabel.hidden=YES;
    }
}

@end
