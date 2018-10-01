//
//  StringColor.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StringColor.h"

@implementation StringColor

+ (NSAttributedString *)setTextColorWithString:(NSString *)string index:(NSUInteger)index textColor:(UIColor *)color{
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = [[textColor string] rangeOfString:[string substringFromIndex:index]];
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return textColor;
}


@end
