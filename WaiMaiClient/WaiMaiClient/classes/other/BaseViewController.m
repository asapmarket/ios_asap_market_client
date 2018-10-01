//
//  BaseViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ThemeColor;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.userInteractionEnabled = YES;
}

- (void)errorResponsText:(NSError *)error{
    [MBProgressHUD hideHUD];
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

#pragma mark 点击空白的地方 收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)dealloc{
    NSLog(@"移除了所有的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
