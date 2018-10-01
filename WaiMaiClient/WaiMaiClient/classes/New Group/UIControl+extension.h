//
//  UIImage+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//



static char OperationKey;

@interface UIControl (extension)
- (void)onClick:(void(^)(id sender))handler;
- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;

@end
