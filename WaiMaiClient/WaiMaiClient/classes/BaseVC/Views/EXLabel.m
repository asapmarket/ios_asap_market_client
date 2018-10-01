//
//  EXLabel.m
//  whcy
//
//  Created by 王 on 2018/4/9.
//  Copyright © 2018年 王. All rights reserved.
//

#import "EXLabel.h"

@implementation EXLabel

+ (VerticalAlignmentLabel *)initLabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor{
    VerticalAlignmentLabel *label = [[VerticalAlignmentLabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.font = font;
    return label;
}

@end
