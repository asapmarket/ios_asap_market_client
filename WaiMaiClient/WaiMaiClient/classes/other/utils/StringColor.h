//
//  StringColor.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringColor : NSObject

+ (NSAttributedString *)setTextColorWithString:(NSString *)string index:(NSUInteger)index textColor:(UIColor *)color;

@end
