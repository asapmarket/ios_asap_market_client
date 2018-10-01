//
//  UIFont+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UIFont+extension.h"

@implementation UIFont (extension)

+(UIFont *)fontOfSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize];
//    return [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:fontSize];
}

+(UIFont *)font{
    return [UIFont fontOfSize:17];
}

+(UIFont *)font10{
  return [UIFont fontOfSize:10];
}

+(UIFont *)font11{
   return [UIFont fontOfSize:11];
}

+(UIFont *)font12{
    return [UIFont fontOfSize:12];
}

+(UIFont *)font13{
    return [UIFont fontOfSize:13];
}

+(UIFont *)font14{
    return [UIFont fontOfSize:14];
}

+(UIFont *)font15{
    return [UIFont fontOfSize:15];
}

+(UIFont *)font16{
    return [UIFont fontOfSize:16];
}

+(UIFont *)font17{
    return [UIFont fontOfSize:17];
}

+(UIFont *)font18{
    return [UIFont fontOfSize:18];
}

+(UIFont *)font21{
    return [UIFont fontOfSize:21];
}

+(UIFont *)font38{
    return [UIFont fontOfSize:38];
}

+(UIFont *)font:(CGFloat)size{
    return [UIFont fontOfSize:size];
}

+(UIFont *)bold{
    return [UIFont boldSystemFontOfSize:17];
}

+(UIFont *)bold:(CGFloat)size{
    return [UIFont boldSystemFontOfSize:size];
}

@end
