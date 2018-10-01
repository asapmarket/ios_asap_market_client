//
//  UIAlertViewExt.m
//  Chason
//
//  Created by Chason on 16/4/11.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "UIAlertViewCustom.h"

@interface UIAlertViewCustom ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)UIAlertController *alertController;
@property(nonatomic,strong)NSArray *buttonTitles;
@property(nonatomic,copy)void (^click)(NSString *buttonTitle);
@end

@implementation UIAlertViewCustom

+(void)showWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles onClick:(void (^)(NSString *buttonTitle))click{
    UIAlertViewCustom *alertView=[[UIAlertViewCustom alloc]init];
    alertView.buttonTitles=buttonTitles;
    alertView.click=click;
    if (isIOS7_9) {
        if (buttonTitles.count==1) {
            alertView.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:alertView cancelButtonTitle:nil otherButtonTitles:buttonTitles.firstObject, nil];
        }
        else if (buttonTitles.count==2){
            alertView.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:alertView cancelButtonTitle:buttonTitles.firstObject otherButtonTitles:buttonTitles.lastObject, nil];
        }
        else{
            alertView.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:alertView cancelButtonTitle:@"确定" otherButtonTitles:nil];
        }
        [alertView.alertView show];
    }
    else {
        alertView.alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (NSString *str in buttonTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (alertView.click) {
                   alertView.click(action.title);
                }
                [alertView removeFromSuperview];
            }];
            [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
            [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
            [alertView.alertController addAction:action];
        }
        [[AppDelegate shared].topVC presentViewController:alertView.alertController animated:YES completion:nil];
    }
    [[AppDelegate shared].topVC.view addSubview:alertView];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.click) {
        self.click(self.buttonTitles[buttonIndex]);
    }
    [self removeFromSuperview];
}

@end
