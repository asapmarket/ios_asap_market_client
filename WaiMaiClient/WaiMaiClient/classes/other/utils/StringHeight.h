//
//  StringHeight.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHeight : NSObject

+ (CGFloat)heightFromString:(NSString*)text withFont:(CGFloat)font constraintToWidth:(CGFloat)width;

+ (CGFloat)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

@end
