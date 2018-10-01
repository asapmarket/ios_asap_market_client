//
//  RegisterViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginTextView.h"
#import "LoginServer.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginTextView *phoneTextView;
@property (nonatomic, strong) LoginTextView *pwdTextView;
@property (nonatomic, strong) LoginTextView *codeTextView;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, strong) UIButton *yesButton;
@property (nonatomic, strong) UIButton *agreement;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *backButton;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeForSendNextVerifyCody;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kRegister1, nil);
    [self setTopBarTitle:NSLocalizedString(kRegister1, nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    _pwdTextView = [[LoginTextView alloc] initWithFrame:CGRectMake(0, 206, SCREEN_WIDTH, 46)];
    [_pwdTextView updateViewWithIsLabel:NO];
    [_pwdTextView setImageViewWithSize:CGSizeMake(14.5, 18)];
    _pwdTextView.imageName = @"password";
    _pwdTextView.myTextField.delegate = self;
    _pwdTextView.myTextField.placeholder = NSLocalizedString(kEnterPwd, nil);
    _pwdTextView.myTextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextView];
    
    _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeButton.frame = CGRectMake(SCREEN_WIDTH-100, 0, 100, 45);
    [_codeButton setTitle:NSLocalizedString(kSendAuthCode, nil) forState:UIControlStateNormal];
    _codeButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_codeButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    _codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_codeButton addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _codeButton.backgroundColor = [UIColor whiteColor];
    [_codeTextView addSubview:_codeButton];
    
    _yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _yesButton.selected = YES;
    _yesButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _yesButton.frame = CGRectMake(TableBorder, 300 , 30, 30);
    [_yesButton setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
    [_yesButton setImage:[UIImage imageNamed:@"yes_click"] forState:UIControlStateSelected];
    [_yesButton setImageEdgeInsets:UIEdgeInsetsMake(8.5, 8.5, 8.5, 8.5)];
    [_yesButton addTarget:self action:@selector(yesButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_yesButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, 88, 30)];
    label.text = NSLocalizedString(kReaderAgreement, nil);
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor hexStringToColor:@"#4d4d4d"];
    [self.view addSubview:label];
    
    
    _agreement = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreement.frame = CGRectMake(115, 300, 95, 30);
    [_agreement setTitle:NSLocalizedString(kUserAgreement, nil) forState:UIControlStateNormal];
    _agreement.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_agreement setTitleColor:ButtonColor forState:UIControlStateNormal];
    _agreement.titleLabel.font = [UIFont systemFontOfSize:11];
    [_agreement addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_agreement];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.frame = CGRectMake(TableBorder, 330, SCREEN_WIDTH-2*TableBorder, 45);
    _registerButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_registerButton setTitle:NSLocalizedString(kRegisterNow, nil) forState:UIControlStateNormal];
    _registerButton.backgroundColor = ButtonColor;
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _registerButton.layer.cornerRadius = 5;
    [self.view addSubview:_registerButton];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake((SCREEN_WIDTH-130)/2.0, 380, 130, 30);
    [_backButton setTitle:NSLocalizedString(kBackToLogin, nil) forState:UIControlStateNormal];
    _backButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_backButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
}

- (void)yesButtonClick{
    if (_yesButton.isSelected) {
        _yesButton.selected = NO;
        _registerButton.backgroundColor = [UIColor hexStringToColor:@"#b3b3b3"];
    }else{
        _yesButton.selected = YES;
        _registerButton.backgroundColor = ButtonColor;
    }
}

- (void)agreementBtnClick{
    if (_yesButton.isSelected) {
        _yesButton.selected = NO;
        _registerButton.backgroundColor = [UIColor hexStringToColor:@"#b3b3b3"];
    }else{
        _yesButton.selected = YES;
        _registerButton.backgroundColor = ButtonColor;
    }
}

- (void)registerButtonClick{
    [self.view endEditing:YES];

    if (_yesButton.isSelected) {
        
        [LoginServer userRegistWithPhone:_phoneTextView.myTextField.text pwd:_pwdTextView.myTextField.text code:_codeTextView.myTextField.text Success:^(id result) {
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kReadUserAgreement, nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify, nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self agreementBtnClick];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:verifyAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
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

- (void)backButtonClick{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
