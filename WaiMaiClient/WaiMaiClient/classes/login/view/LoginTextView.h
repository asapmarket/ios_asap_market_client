//
//  LoginTextView.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextView : UIView

@property (nonatomic, strong) UITextField *myTextField;
@property (nonatomic, strong) NSString *imageName;

- (void)updateViewWithIsLabel:(BOOL)isLabel;
- (void)setImageViewWithSize:(CGSize)size;

@end
