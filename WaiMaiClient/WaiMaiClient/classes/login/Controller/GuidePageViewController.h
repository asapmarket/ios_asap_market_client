//
//  GuidePageViewController.h
//  qk
//
//  Created by 王 on 2017/7/14.
//  Copyright © 2017年 qk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuidePageViewControllerDelegate <NSObject>

- (void)upgradeGiftViewCancel;

@end

@interface GuidePageViewController : UIViewController

@property (nonatomic, weak) id<GuidePageViewControllerDelegate>delegate;

+ (BOOL)shouldShowGuidePage;

@end
