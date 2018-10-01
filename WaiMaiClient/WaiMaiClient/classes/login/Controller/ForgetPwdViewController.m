//
//  ForgetPwdViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "LoginTextView.h"
#import "LoginServer.h"

@interface ForgetPwdViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginTextView *phoneTextView;
@property (nonatomic, strong) LoginTextView *pwdTextView;
@property (nonatomic, strong) LoginTextView *verifyPwdtextView;
@property (nonatomic, strong) LoginTextView *codeTextView;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeForSendNextVerifyCody;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopBarTitle:NSLocalizedString(kFindPwd, nil)];
    
    self.timeForSendNextVerifyCody = SendNextVerifyCode;

    [self updateView];
}

- (void)updateView{
    _phoneTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, 46)];
    [_phoneTextView updateViewWithIsLabel:NO];
    [_phoneTextView setImageViewWithSize:CGSizeMake(13.5, 18.5)];
    _phoneTextView.imageName = @"phone";
    _phoneTextView.myTextField.delegate = self;
    _phoneTextView.myTextField.placeholder = NSLocalizedString(kEnterPhoneNO, nil);
    _phoneTextView.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextView];
    
    _codeTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 46)];
    [_codeTextView updateViewWithIsLabel:NO];
    _codeTextView.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_codeTextView setImageViewWithSize:CGSizeMake(15.5, 15.5)];
    _codeTextView.imageName = @"write";
    _codeTextView.myTextField.delegate = self;
    _codeTextView.myTextField.placeholder = NSLocalizedString(kEnterAuthCode, nil);
    [self.view addSubview:_codeTextView];
    
    _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeButton.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 45);
    [_codeButton setTitle:NSLocalizedString(kSendAuthCode, nil) forState:UIControlStateNormal];
    _codeButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_codeButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    _codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_codeButton addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _codeButton.backgroundColor = [UIColor whiteColor];
    [_codeTextView addSubview:_codeButton];
    
    _pwdTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 196, SCREEN_WIDTH, 46)];
    [_pwdTextView updateViewWithIsLabel:NO];
    [_pwdTextView setImageViewWithSize:CGSizeMake(14.5, 18)];
    _pwdTextView.imageName = @"password";
    _pwdTextView.myTextField.delegate = self;
    _pwdTextView.myTextField.placeholder = NSLocalizedString(kEnterNewPwd, nil);
    _pwdTextView.myTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextView];
    
    _verifyPwdtextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 242, SCREEN_WIDTH, 46)];
    [_verifyPwdtextView updateViewWithIsLabel:NO];
    [_verifyPwdtextView setImageViewWithSize:CGSizeMake(14.5, 18)];
    _verifyPwdtextView.imageName = @"password";
    _verifyPwdtextView.myTextField.delegate = self;
    _verifyPwdtextView.myTextField.placeholder = NSLocalizedString(kVerNewPwd, nil);
    _verifyPwdtextView.myTextField.secureTextEntry = YES;
    [self.view addSubview:_verifyPwdtextView];

    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake(10, 330, SCREEN_WIDTH-20, 45);
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
    NSString *phoneNO = _phoneTextView.myTextField.text;
    if (phoneNO.length == 0) {
        [MBProgressHUD showError:NSLocalizedString(kEnterPhoneNO, nil)];
        return;
    }
    [LoginServer forgetPwdWithPhone:phoneNO code:_codeTextView.myTextField.text pwd:_pwdTextView.myTextField.text Success:^(id result) {
        [MBProgressHUD showSuccess:@""];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    NSLog(@"提交");
}

- (void)codeBtnClick{
    NSString *phoneNO = _phoneTextView.myTextField.text;
    if (phoneNO.length == 0) {
        [MBProgressHUD showError:NSLocalizedString(kEnterPhoneNO, nil)];
        return;
    }
    [LoginServer getCerCodeWithPhoneNO:phoneNO Success:^(CodeModel *result) {
//        _codeTextView.myTextField.text = result.code;
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(timeForSendVeryfyCode)
                                                    userInfo:nil
                                                     repeats:YES];
        
        
    }
}

- (void)timeForSendVeryfyCode
{
    self.timeForSendNextVerifyCody --;
    if (self.timeForSendNextVerifyCody == 0) {
        [_codeButton setTitle: NSLocalizedString(kSendAuthCode, nil) forState:UIControlStateNormal];
        [_codeButton setTitleColor:ButtonColor forState:UIControlStateNormal];
        [_codeButton setEnabled:YES];
        [self.timer invalidate];
        self.timer = nil;
        self.timeForSendNextVerifyCody = SendNextVerifyCode;
    } else {
        [_codeButton setTitle:[NSString stringWithFormat:@"%@%ldS",NSLocalizedString(kSendCodeAgain, nil),(long)self.timeForSendNextVerifyCody] forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1] forState:UIControlStateNormal];
    }
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
