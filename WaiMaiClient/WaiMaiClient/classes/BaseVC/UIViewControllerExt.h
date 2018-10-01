//
//  UIViewControllerExt.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewControllerExt : UIViewController
@property(nonatomic,assign)UIStatusBarStyle statusBarStyle;
@property(nonatomic,strong)UIImageView *backgroundView;
@property(nonatomic,strong)NSString *backgroundImage;
@property(nonatomic,assign)BOOL isFirstAppear;
@property(nonatomic,assign)BOOL canPan;
@property(nonatomic,strong)NSString *itemTitle;

@property (nonatomic, assign) BOOL isHasTabbar;


- (void)errorResponsText:(NSError *)error;

- (void)arlertShowWithText:(NSString *)text;

-(void)viewFirstAppear;

@end

