//
//  WTabBarController.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMTabBar.h"

@interface WTabBarController : UITabBarController

- (void)WTabBarViewControllerToHome;

- (void)WTabBarViewControllerToOrder;

@property (nonatomic, strong) WMTabBar *tabBar;

@end
