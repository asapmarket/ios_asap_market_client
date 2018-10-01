//
//  WTabBarController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "WTabBarController.h"
#import "IndentViewController.h"
#import "MineViewController.h"
#import "HomePageViewController.h"
#import "WalletViewController.h"
#import "ShopCartViewController.h"

@interface WTabBarController ()


@end

@implementation WTabBarController

#pragma mark - 统一设置所有 UITabBarItem 的文字属性
+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"#2196f3"];
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self addChildViewControllers];
        [self InitMiddleView];
    }
    return self;
}

- (void)InitMiddleView
{
    
    self.tabBar = [[WMTabBar alloc] init];
    [self setValue:self.tabBar forKey:@"tabBar"];
    [self.tabBar setDidMiddBtn:^{
        ShopCartViewController *vc = [[ShopCartViewController alloc] init];
        [[AppDelegate shared].curNav pushViewController:vc animated:YES];
    }];
}

#pragma mark - 添加所有子控制器
- (void)addChildViewControllers {
    [self addChildViewControllerClassName:@"HomePageViewController" title:NSLocalizedString(kHome, nil) imageName:@"home"];
    [self addChildViewControllerClassName:@"WalletViewController" title:NSLocalizedString(@"kRewardPoint", nil) imageName:@"tab_wallet"];
    [self addChildViewControllerClassName:@"IndentViewController" title:NSLocalizedString(kOrder, nil) imageName:@"indent"];
    [self addChildViewControllerClassName:@"MineViewController" title:NSLocalizedString(kVipCenter, nil) imageName:@"me"];
}

#pragma mark - 设置所有子控制器
- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName
{
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    UINavigationControllerExt *nav = [[UINavigationControllerExt alloc] initWithRootViewController:viewController];
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.image = [UIImage imageNamed: imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_click", imageName]];
    [self addChildViewController:nav];
}

- (void)WTabBarViewControllerToOrder{
    self.selectedIndex = 3;
}

- (void)WTabBarViewControllerToHome{
    self.selectedIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
