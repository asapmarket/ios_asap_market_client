//
//  UIColor+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//


#define Red(rgb)  ((rgb&0xff0000)>>16)
#define Green(rgb)  ((rgb&0xff00)>>8)
#define Blue(rgb)  (rgb&0xff)
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBHex(rgb) [UIColor colorWithRGB:(rgb)]
#define RGBHexA(rgb,a) [UIColor colorWithRGB:(rgb) alpha:(a)]

@interface UIColor (extension)

+ (UIColor *)color;
+ (UIColor *)colorWithRGB:(int)rgb;
+ (UIColor *)colorWithRGB:(int)rgb alpha:(CGFloat)alpha;

+ (UIColor *)navigationBarColor;
+ (UIColor *)navigationItemColor;
+ (UIColor *)tabBarColor;
+ (UIColor *)background;

+ (UIColor *)text;
+ (UIColor *)text3;
+ (UIColor *)text6;
+ (UIColor *)text9;

+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

-(int)hexValue;

@end
