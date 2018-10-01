//
//  UINavigationControllerExt.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UINavigationControllerExt.h"
#import "UIViewControllerExt.h"

@interface UINavigationControllerExt()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation UINavigationControllerExt

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self=[super initWithRootViewController:rootViewController];
    if (self) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (1 == navigationController.viewControllers.count) {
        self.viewController = nil;
    } else {
        self.viewController = viewController;
    }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewController==self.topViewController) {
            if ([self.topViewController isKindOfClass:[UIViewControllerExt class]]) {
                UIViewControllerExt *vc=(UIViewControllerExt *)self.topViewController;
                return vc.canPan;
            }
        }
        return self.viewController == self.topViewController;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return NO;
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:[UIColor whiteColor]];
    
    //设置返回按钮图片
    UIImage *backButtonImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    appearance.backIndicatorImage = backButtonImage;
    appearance.backIndicatorTransitionMaskImage = backButtonImage;
    
    //设置返回按钮文字样式
    UIBarButtonItem *itemAppearance = [UIBarButtonItem appearance];
    [itemAppearance setTintColor:[UIColor navigationItemColor]];
    
    [itemAppearance setBackButtonTitlePositionAdjustment:UIOffsetMake(-kScreenWidth * 5, 0) forBarMetrics:UIBarMetricsDefault];
    
}

@end
