//
//  UIButton+ImageTitleV.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImageTitleV)

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, weak) id object;

- (void)verticalImageAndTitle:(CGFloat)spacing;

- (void)letfTextRightImage;

- (void)rightImageLeftText;
@end
