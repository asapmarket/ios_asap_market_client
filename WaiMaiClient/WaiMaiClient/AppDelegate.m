//
//  AppDelegate.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import "AppDelegate.h"
#import "WTabBarController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Bugly/Bugly.h>
#import "GuidePageViewController.h"
#import "PayPalMobile.h"
#import <Stripe/Stripe.h>
#import "IQKeyboardManager.h"

/**
 谷歌Key
 */
static NSString *const kAPIKey = @"AIzaSyCWg2zWqNwJdAbJcr0LYr7H27VV1iDARZI";

#define BUGLY_APP_ID @"61107bf929"

@interface AppDelegate ()<GuidePageViewControllerDelegate>{
    id _services;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[LanguageManager shareManager] initUserLanguage];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarTintColor=[UIColor blackColor];
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText=@"完成";
    [IQKeyboardManager sharedManager].toolbarBarTintColor=[UIColor whiteColor];
    [[UITextField appearance] setTintColor:[UIColor hexStringToColor:@"#DBDBDB"]];

    // 设置NavigationBar.title
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName,  nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChange:) name:LanguageChange object:nil];
    
    //引导页
    [self guidePageViewController];
    
    //paypal
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AWzwurzNKUo-2KhTE1qnkkKA4uep3dg8n-QMVNL32DR1dbmMR5w5wzPvHQjqvPNzDJIhrZ_twZVeXEbq",
                                                           PayPalEnvironmentSandbox : @"AXCrgSkAyC3E2ePWU6Tph-WJZDd6xfPY9CRTWCusQ7hR6w5SQewvJxPx84kZH7IHiF9mdVVji8bjGYyB"}];
    //刷卡支付
    [Stripe setDefaultPublishableKey:StripePublishableKey];
    [self GMapServer];
    [self setupBugly];
    return YES;
}


- (void)guidePageViewController{
    if ([GuidePageViewController shouldShowGuidePage]) {
        GuidePageViewController *guidePage = [[GuidePageViewController alloc] init];
        guidePage.delegate = self;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.window.rootViewController = guidePage;
            
        } completion:^(BOOL finished) {
        }];
        
    }else{
        [self upgradeGiftViewCancel];
    }

}

- (void)upgradeGiftViewCancel{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    WTabBarController *tabBar = [[WTabBarController alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.window.rootViewController = tabBar;
}



- (void)languageChange:(NSNotification *)notifi{
    NSLog(@"%@",[notifi object]);
    [[LanguageManager shareManager] setUserLanguage:[notifi object]];
    WTabBarController *tabBar = [[WTabBarController alloc] init];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
}

- (void)GMapServer{
    [GMSServices provideAPIKey:kAPIKey];
    _services = [GMSServices sharedServices];
}

- (void)setupBugly {
    // Get the default config
    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    // Open the debug mode to print the sdk log message.
    // Default value is NO, please DISABLE it in your RELEASE version.
    //#if DEBUG
    config.debugMode = YES;
    //#endif
    
    // Open the customized log record and report, BuglyLogLevelWarn will report Warn, Error log message.
    // Default value is BuglyLogLevelSilent that means DISABLE it.
    // You could change the value according to you need.
    //    config.reportLogLevel = BuglyLogLevelWarn;
    
    // Open the STUCK scene data in MAIN thread record and report.
    // Default value is NO
    config.blockMonitorEnable = YES;
    
    // Set the STUCK THRESHOLD time, when STUCK time > THRESHOLD it will record an event and report data when the app launched next time.
    // Default value is 3.5 second.
    config.blockMonitorTimeout = 1.5;
    
    // Set the app channel to deployment
    config.channel = @"Bugly";
    
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    
    // NOTE:Required
    // Start the Bugly sdk with APP_ID and your config
    [Bugly startWithAppId:BUGLY_APP_ID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
    // Set the customizd tag thats config in your APP registerd on the  bugly.qq.com
    // [Bugly setTag:1799];
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
