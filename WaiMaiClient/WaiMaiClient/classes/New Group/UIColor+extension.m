//
//  UIColor+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UIColor+extension.h"

@implementation UIColor (extension)

+ (UIColor *)color{
    return RGB(45, 180, 222);
}

+ (UIColor *)colorWithRGB:(int)rgb{
    return [UIColor colorWithRed:Red(rgb)/255.0 green:Green(rgb)/255.0 blue:Blue(rgb)/255.0 alpha:1.0];
}

+ (UIColor *)colorWithRGB:(int)rgb alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:Red(rgb)/255.0 green:Green(rgb)/255.0 blue:Blue(rgb)/255.0 alpha:alpha];
}

+ (UIColor *)navigationBarColor{
    return [UIColor whiteColor];
}

+ (UIColor *)navigationItemColor{
     return [UIColor text3];
}

+ (UIColor *)tabBarColor{
    return RGBHex(0x6b4096);
}

+ (UIColor *)background{
    return ThemeColor;
}

+ (UIColor *)text{
    return RGB(45, 180, 222);
}

+ (UIColor *)text3{
    return RGB(51, 51, 51);
}

+ (UIColor *)text6{
    return RGB(102, 102, 102);
}

+ (UIColor *)text9{
    return RGB(153, 153, 153);
}

-(int)hexValue{
    UIColor *color=self;
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
        return [[NSString stringWithFormat:@"#FFFFFF"] hexValue];
    }
    
    return [[NSString stringWithFormat:@"#%0xd%0xd%0xd", (int)((CGColorGetComponents(self.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(self.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(self.CGColor))[2]*255.0)] hexValue];
}

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearss
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
