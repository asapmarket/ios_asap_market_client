//
//  AmendViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "AmendViewController.h"
#import "LoginTextView.h"
#import "MeServer.h"

@interface AmendViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginTextView *oldPwdTextView;
@property (nonatomic, strong) LoginTextView *pwdTextView;
@property (nonatomic, strong) LoginTextView *verifyPwdtextView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation AmendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = NSLocalizedString(kModifyPwd, nil);
    
    [self setTopBarTitle:NSLocalizedString(kModifyPwd, nil)];
    
    [self updateView];
}

- (void)updateView{
    _oldPwdTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, 46)];
    [_oldPwdTextView updateViewWithIsLabel:NO];
    [_oldPwdTextView setImageViewWithSize:CGSizeMake(15.5, 15.5)];
    _oldPwdTextView.imageName = @"write";
    _oldPwdTextView.myTextField.delegate = self;
    _oldPwdTextView.myTextField.placeholder = NSLocalizedString(kEnterOldPwd, nil);
    [self.view addSubview:_oldPwdTextView];

    _pwdTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 46)];
    [_pwdTextView updateViewWithIsLabel:NO];
    [_pwdTextView setImageViewWithSize:CGSizeMake(14.5, 18)];
    _pwdTextView.imageName = @"password";
    _pwdTextView.myTextField.delegate = self;
    _pwdTextView.myTextField.placeholder = NSLocalizedString(kEnterNewPwd, nil);
    _pwdTextView.myTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextView];
    
    _verifyPwdtextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 196, SCREEN_WIDTH, 46)];
    [_verifyPwdtextView updateViewWithIsLabel:NO];
    [_verifyPwdtextView setImageViewWithSize:CGSizeMake(14.5, 18)];
    _verifyPwdtextView.imageName = @"password";
    _verifyPwdtextView.myTextField.delegate = self;
    _verifyPwdtextView.myTextField.placeholder = NSLocalizedString(kVerNewPwd, nil);
    _verifyPwdtextView.myTextField.secureTextEntry = YES;
    [self.view addSubview:_verifyPwdtextView];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(10, 300, SCREEN_WIDTH-20, 45);
    [_submitButton setTitle:NSLocalizedString(kSubmit, nil) forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.layer.cornerRadius = 5;
    [_submitButton setBackgroundColor:ButtonColor];
    [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];

}

- (void)submitClick{
    if (![_verifyPwdtextView.myTextField.text isEqualToString:_pwdTextView.myTextField.text]) {
        [self arlertShowWithText:NSLocalizedString(kVerNewPwd, nil)];
        return;
    }
    
    [MeServer updatePwdWithOldPwd:_oldPwdTextView.myTextField.text newPwd:_pwdTextView.myTextField.text Success:^(id result) {
        [MBProgressHUD showSuccess:@""];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
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
