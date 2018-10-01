//
//  LanguageManager.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

+ (LanguageManager *)shareManager;

- (void)initUserLanguage;
    
- (NSString *)userLanguage;
    
- (void)setUserLanguage:(NSString *)language;
@property (nonatomic, assign) NSInteger language; //0:英文 1：中文


@end
