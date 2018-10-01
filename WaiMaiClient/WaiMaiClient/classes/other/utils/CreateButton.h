//
//  CreateButton.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiParamButton.h"

@interface CreateButton : NSObject

+ (MultiParamButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title backCoclor:(UIColor *)backColor tittleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;

+ (UIButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title backCoclor:(UIColor *)backColor tittleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIButton *)initWithimage:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;
/**
边框按钮
 */
+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;
@end
