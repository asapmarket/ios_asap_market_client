//
//  AppDelegate+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (extension)
@property(nonatomic,weak,readonly)UINavigationController * _Nullable curNav;
@property(nonatomic,weak,readonly)UIViewController * _Nullable topVC;

+ (AppDelegate *_Nullable)shared;

- (void)presentViewController:(UIViewController * _Nullable)viewController animated:(BOOL)animated completion:(void(^_Nullable)(void))completion;

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;

- (void)pushViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;

- (void)popToRootViewControllerAnimated:(BOOL)animated;

- (void)popToViewController:(Class _Nullable )viewController animated:(BOOL)animated;

- (void)removeGuidePageViewController;

@end
