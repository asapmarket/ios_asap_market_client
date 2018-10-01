//
//  AppDelegate+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "AppDelegate+extension.h"

@implementation AppDelegate (extension)

+(AppDelegate *)shared{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion{
    [self.topVC presentViewController:viewController animated:animated completion:completion];
}

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion{
    [self.topVC dismissViewControllerAnimated:flag completion:completion];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.curNav isKindOfClass:[UINavigationController class]]) {
        [self.curNav pushViewController:viewController animated:animated];
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated{
    if ([self.curNav isKindOfClass:[UINavigationController class]]) {
        [self.curNav popToRootViewControllerAnimated:animated];
    }
}

- (void)popToViewController:(Class)viewController animated:(BOOL)animated{
    if ([self.curNav isKindOfClass:[UINavigationController class]]) {
        if (!viewController) {
             [self.curNav popViewControllerAnimated:animated];
            return;
        }
        for ( id vc in self.curNav.viewControllers) {
            if ([vc isKindOfClass:viewController]) {
                [self.curNav popToViewController:vc animated:animated];
                return;
            }
        }
        [self.curNav popToRootViewControllerAnimated:animated];
    }
}

-(UIViewController *)topVC{
    if ([self.curNav isKindOfClass:[UINavigationController class]]) {
        return (UIViewController *)self.curNav.topViewController;
    }
    return self.window.rootViewController;
}

-(UINavigationController *)curNav{
    return [self recursiveViewController:self.window.rootViewController];
}

- (UINavigationController *)recursiveViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self recursiveViewController:[(UINavigationController *)vc visibleViewController]];
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self recursiveViewController:[(UITabBarController *)vc selectedViewController]];
    }
    if (vc.presentedViewController) {
        return [self recursiveViewController:vc.presentedViewController];
    }
    if ([vc isKindOfClass:[UISearchController class]]) {
        UIViewController *presentingViewController = vc.presentingViewController;
        if ([presentingViewController isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)presentingViewController;
        } else {
            return presentingViewController.navigationController;
        }
    }
    return vc.navigationController;
}


@end
