//
//  CreateLabel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerticalAlignmentLabel.h"

@interface CreateLabel : NSObject

+ (VerticalAlignmentLabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

@end
