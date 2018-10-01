//
//  EXLabel.h
//  whcy
//
//  Created by 王 on 2018/4/9.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerticalAlignmentLabel.h"

@interface EXLabel : NSObject

+ (VerticalAlignmentLabel *)initLabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor;

@end
