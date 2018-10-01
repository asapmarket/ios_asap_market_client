//
//  UIViewController+DeanTopBar.h
//  Ruyue
//
//  Created by lyywhg on 15/6/2.
//  Copyright (c) 2015年 ADean. All rights reserved.
//

#import "UIButtonCustom.h"

@interface UIViewController (extension)

@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UILine *topBottomLine;
@property (nonatomic, strong) UIButtonCustom *backButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *topTitleLabel;

@property (nonatomic, strong,readonly) UIView *customView;

/** 设置TopView-仅左边通用返回按钮 */
- (void)setTopBarTitle:(NSString*)title;

- (void)setTopBarCustom:(UIView*)customView;

/** 设置TopView-仅左边文字返回按钮 */
- (void)setTopBarTitle:(NSString*)title leftTextButton:(NSString *)text;

/** 设置TopView-左侧通用返回按钮+右侧图片按钮 */
- (void)setTopBarTitle:(NSString*)title rightImage:(NSString*)imgName;

/** 设置TopView-左侧通用按钮+右侧文字按钮 */
- (void)setTopBarTitle:(NSString*)title rightText:(NSString*)text;

/** 设置TopView-左边文字和通用返回按钮 */
- (void)setTopBarTitle:(NSString*)title leftTextButton:(NSString *)text needLeftImage:(BOOL)needLeftImage;

- (void)setTopBarTitle:(NSString*)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImgName;


/** 通用返回按钮，如需定制则修改backBtn按钮*/
- (void)leftButtonAction;
/** 通用返回按钮，如需定制则修改rightBtn按钮*/
- (void)rightButtonAction;

@end
