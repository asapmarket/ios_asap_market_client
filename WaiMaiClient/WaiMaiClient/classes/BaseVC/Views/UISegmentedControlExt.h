//
//  UISegmentedControlExt.h
//  Chason
//
//  Created by Chason on 16/8/22.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControlExt : UIView
@property(nonatomic,strong)UIFont * __nullable font;
@property(nonatomic,strong)UIColor * __nullable normalColor;
@property(nonatomic,strong)UIColor * __nullable selectedColor;
@property(nonatomic,strong)UIImage * __nullable normalBackgroundImage;
@property(nonatomic,strong)UIImage * __nullable selectedBackgroundImage;
@property(nonatomic,assign)BOOL seperateLineHidden;
@property(nonatomic,assign)float seperateLineHeight;
@property(nonatomic,strong)UIColor * __nullable seperateLineColor;


@property(nonatomic)int selectedIndex;

@property(nonatomic,strong)void (^ __nullable valueChange)(int index);

- (__nullable instancetype)initWithItems:(nullable NSArray *)items height:(CGFloat)height;
- (__nullable instancetype)initWithItems:(nullable NSArray *)items frame:(CGRect)frame;

@end
