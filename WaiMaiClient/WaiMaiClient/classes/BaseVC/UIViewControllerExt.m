//
//  UIViewControllerExt.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UIViewControllerExt.h"

@interface UIViewControllerExt ()

@end

@implementation UIViewControllerExt


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarStyle=UIStatusBarStyleDefault;
        self.canPan=YES;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor background];
    _backgroundView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    _backgroundView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_backgroundView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.topBottomLine.hidden=NO;
    self.topBarView.backgroundColor = [UIColor navigationBarColor];
}

-(void)setItemTitle:(NSString *)itemTitle{
    _itemTitle=itemTitle;
    self.yp_tabItemTitle=itemTitle;
}

-(void)setBackgroundImage:(NSString *)backgroundImage{
    _backgroundImage=backgroundImage;
    _backgroundView.image=[UIImage imageNamed:backgroundImage];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_isFirstAppear) {
        [self viewFirstAppear];
        _isFirstAppear=YES;
    }
    if (self.statusBarStyle!=UIStatusBarStyleLightContent) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    [self.view bringSubviewToFront:self.topBarView];
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    if (self.statusBarStyle!=statusBarStyle) {
        _statusBarStyle=statusBarStyle;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)viewFirstAppear{
    
}

- (void)errorResponsText:(NSError *)error{
    NSString *errorStr = [[error userInfo] objectForKey:kResultErrorDesKey];
    [self arlertShowWithText:errorStr];
    NSInteger code = [error code];
    if (code == 10023 || code == 10025 || code == 10011){
        [LoginManager toLogin];
    }
}

- (void)arlertShowWithText:(NSString *)text{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2.0-64, SCREEN_WIDTH-20, 40)];
    view.layer.cornerRadius = 8;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    UILabel *label = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    label.text = text;
    label.frame = view.bounds;
    [view addSubview:label];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@释放了内存",NSStringFromClass([self class]));
}

@end
