//
//  UIPageViewControllerExt.m
//  SSKingdom
//
//  Created by chason on 2017/12/20.
//  Copyright © 2017年 3Songshu. All rights reserved.
//

#import "UIPageViewControllerExt.h"

@interface UIPageViewControllerExt ()

@end

@implementation UIPageViewControllerExt

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initPageItem];
    [self setViewControllers:self.pageVCArray];
}

#pragma mark - Data 方法

- (void)initPageItem{
    
    self.tabBar.itemSeparatorWidth = 50;
    
    self.tabBar.itemSelectedBgColor = RGBHex(0xffffff);
    self.tabBar.itemTitleColor = RGBHex(0xffffff);
    self.tabBar.itemSelectedBgCornerRadius = 12;
    self.tabBar.itemTitleSelectedColor = [UIColor color];
    self.tabBar.itemTitleFont = [UIFont font:14];
    self.tabBar.itemTitleSelectedFont = [UIFont font:14];
    
    self.tabBar.backgroundColor = [UIColor clearColor];
    
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
    //    [self.tabBar setItemSelectedBgInsets:UIEdgeInsetsMake(40+1, 0, 0, 0) tapSwitchAnimated:NO];//item下划线大小调整
    
    [self setTabBarFrame:CGRectMake(0, self.topBarView.height, self.view.width, 30)
        contentViewFrame:CGRectMake(0, self.topBarView.height + 30, self.view.width, self.view.height - self.topBarView.height - 30-IPhoneBottomOffset)];
    
    [self setContentScrollEnabledAndTapSwitchAnimated:NO];
}

-(NSArray<UIViewController *> *)pageVCArray{
    return @[];
}

@end
