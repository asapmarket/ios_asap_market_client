//
//  LanguageManager.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager
  
static NSBundle *bundle = nil;
    
+ (LanguageManager *)shareManager{
    static LanguageManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (nil == manager) {
            manager = [[LanguageManager alloc] init];
            bundle = [NSBundle mainBundle];
        }
    });
    return manager;
}
    
- (void)initUserLanguage {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *string = [def valueForKey:kNowLanguage];
    
    if (string.length == 0) {
        //获取系统当前语言版本（中文zh-Hans,英文en)
        NSArray *languages = [def objectForKey:@"AppleLanguages"];
        NSString *current =[languages objectAtIndex:0];
//        string = kSetChinese;
        [def setValue:current forKey:kNowLanguage];
        [def synchronize];
    }
    if ([string isEqualToString:kSetEnglish]) {
        _language = 0;
    }else{
        _language = 1;
    }
    
    [NSBundle setLanguage:string];
}
    
//获得当前语言的方法
- (NSString *)userLanguage {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:kNowLanguage];
    return language;
}
    
    //设置语言
- (void)setUserLanguage:(NSString *)language{
    if ([language isEqualToString:kSetEnglish]) {
        _language = 0;
    }else{
        _language = 1;
    }
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];

    [NSBundle setLanguage:language];
    
    //2.持久化
    [def setValue:language forKey:kNowLanguage];
    [def synchronize];
}
    
@end
