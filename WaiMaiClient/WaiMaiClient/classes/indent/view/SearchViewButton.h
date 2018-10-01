//
//  SearchViewButton.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewButton : NSObject

+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIButton *)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;

@end
