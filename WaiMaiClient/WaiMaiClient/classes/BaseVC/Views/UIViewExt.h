//
//  UIViewExt.h
//  whcy
//
//  Created by 王 on 2018/4/11.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewExt : UIView

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
-(void)addTarget:(id)target action:(SEL)action;

@end
