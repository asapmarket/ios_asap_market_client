//
//  UIAlertViewExt.h
//  Chason
//
//  Created by Chason on 16/4/11.
//  Copyright © 2016年 Chason. All rights reserved.
//



@interface UIAlertViewCustom : UIView
+(void)showWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles onClick:(void (^)(NSString *buttonTitle))click;
@end
