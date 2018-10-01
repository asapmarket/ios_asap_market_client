//
//  LoginViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextView.h"
#import "UIBarButtonItem+MJ.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "LoginServer.h"
#import "WTabBarController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginTextView *phoneTextView;
@property (nonatomic, strong) LoginTextView *pwdTextView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *forgetPwdBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kLogin, nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateView];
}

- (void)updateView{
    
    _phoneTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, 46)];
    [_phoneTextView updateViewWithIsLabel:NO];
    [_phoneTextView setImageViewWithSize:CGSizeMake(13.5, 18.5)];
    _phoneTextView.imageName = @"phone";
    _phoneTextView.myTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:_phoneTextView.myTextField];
    _phoneTextView.myTextField.placeholder = NSLocalizedString(kEnterPhoneNO, nil);
    _phoneTextView.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextView];
    
    _pwdTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 46)];
    [_pwdTextView updateViewWithIsLabel:NO];
    [_pwdTextView setImageViewWithSize:CGSizeMake(14.5, 18)];
    _pwdTextView.imageName = @"password";
    _pwdTextView.myTextField.delegate = self;
    _pwdTextView.myTextField.placeholder = NSLocalizedString(kEnterPwd, nil);
    _pwdTextView.myTextField.secureTextEntry = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:_pwdTextView.myTextField];
    [self.view addSubview:_pwdTextView];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(10, 240, SCREEN_WIDTH-20, 45);
    [_loginButton setTitle:NSLocalizedString(kLogin, nil) forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _loginButton.layer.cornerRadius = 5;
    [_loginButton setBackgroundColor:ButtonColor];
    [_loginButton addTarget:self action:@selector(toLlogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(25, 300, 60, 30);
    [_registerBtn setTitle:NSLocalizedString(kRegisterNow, nil) forState:UIControlStateNormal];
    _registerBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_registerBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_registerBtn addTarget:self action:@selector(immediatelyRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetPwdBtn.frame = CGRectMake(SCREEN_WIDTH-85, 300, 60, 30);
    [_forgetPwdBtn setTitle:NSLocalizedString(kForgetPwd, nil) forState:UIControlStateNormal];
    _forgetPwdBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_forgetPwdBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
    _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPwdBtn];

}

- (void)phoneTextFieldDidChange{

}

- (void)passwordTextFieldDidChange{
    
}

//登录
- (void)toLlogin{
    
    NSString *phone = self.phoneTextView.myTextField.text;
    NSString *pwd = self.pwdTextView.myTextField.text;
    
    if (phone.length == 0) {
        [MBProgressHUD showError:NSLocalizedString(kEnterPhoneNO, nil)];
        return;
    }
    
    if (pwd.length == 0) {
        [MBProgressHUD showError:NSLocalizedString(kEnterPwd, nil)];
        return;
    }
    
    [LoginServer loginWithPhone:phone pwd:pwd Success:^(UserInfo *result) {
        [self saveLoginResult:result];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)saveLoginResult:(UserInfo *)userInfo
{
    [UserInfoTool saveLoginAccount:userInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//立即注册
- (void)immediatelyRegister{
    RegisterViewController *registCtrl = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registCtrl animated:YES];
}
//忘记密码
- (void)forgetPassword{
    ForgetPwdViewController *forgetCtrl = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetCtrl animated:YES];
}

- (void)leftButtonAction{
    [self.view endEditing:YES];

    WTabBarController *tabBar = [[WTabBarController alloc] init];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}

//UITextField的代理方法，点击键盘return按钮退出键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
