//
//  CreditCardViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/9/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CreditCardViewController.h"
#import "OederDetailViewController.h"
#import "MeServer.h"
#import<CommonCrypto/CommonDigest.h>
#import "CreditCardTextView.h"
#import "StringColor.h"
#import "PaymentModel.h"

@interface CreditCardViewController ()<CreditCardTextViewDelegate>

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) CreditCardTextView *cardNoTextView;
@property (nonatomic, strong) CreditCardTextView *dateTextView;
@property (nonatomic, strong) CreditCardTextView *cvvTextView;
@property (nonatomic, strong) CreditCardTextView *addressTextView;
@property (nonatomic, strong) CreditCardTextView *firstNameTextView;
@property (nonatomic, strong) CreditCardTextView *lastNameTextView;
@property (nonatomic, strong) CreditCardTextView *zipTextView;
@property (nonatomic, strong) UILabel *descLabel;


@end

@implementation CreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTopBarTitle:NSLocalizedString(kAddCreditCard, nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    
}



- (void)initView{
    
    CGFloat height = TopBarHeight + 20;
    
    _cardNoTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _cardNoTextView.delegate = self;
    _cardNoTextView.tag = 1000;
    _cardNoTextView.descStr = NSLocalizedString(kCreditCardNO, nil);
    [self.view addSubview:_cardNoTextView];
    
    height += 40;
    
    _dateTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _dateTextView.delegate = self;
    _dateTextView.tag = 1001;
    _dateTextView.descStr = NSLocalizedString(kValidity, nil);
    [self.view addSubview:_dateTextView];
    
    height += 40;
    
    _addressTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _addressTextView.delegate = self;
    _addressTextView.tag = 1002;
    _addressTextView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:_addressTextView];
    
    height += 40;

    _cvvTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _cvvTextView.delegate = self;
    _cvvTextView.tag = 1003;
    _cvvTextView.descStr = @"CVV:";
    [self.view addSubview:_cvvTextView];
    
    height += 40;

    _lastNameTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _lastNameTextView.delegate = self;
    _lastNameTextView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _lastNameTextView.tag = 1005;
    [self.view addSubview:_lastNameTextView];
    
    height += 40;
    
    _firstNameTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _firstNameTextView.delegate = self;
    _firstNameTextView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _firstNameTextView.tag = 1004;
    [self.view addSubview:_firstNameTextView];
    
    height += 40;
    
    _zipTextView = [[CreditCardTextView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 35)];
    _zipTextView.delegate = self;
    _zipTextView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _zipTextView.tag = 1006;
    [self.view addSubview:_zipTextView];
    
    
    _lastNameTextView.textField.placeholder = @"Last Name";
    _firstNameTextView.textField.placeholder = @"First Name";

    if ([LanguageManager shareManager].language == 0) {
        _cardNoTextView.textField.placeholder = @"Please enter card NO.";
        _dateTextView.textField.placeholder = @"Please enter Year month like:0817";
        _addressTextView.textField.placeholder = @"Address";
        _addressTextView.descStr = @"Address:";
        _lastNameTextView.descStr = @"First name:";
        _firstNameTextView.descStr = @"Last name:";
        _zipTextView.descStr = @"zipCode:";

    }else{
        _cardNoTextView.textField.placeholder = @"请输入卡号";
        _dateTextView.textField.placeholder = @"请输入有效期月年，例如：0817";
        _addressTextView.textField.placeholder = @"地址";
        _addressTextView.descStr = @"地址:";
        _lastNameTextView.descStr = @"姓:";
        _firstNameTextView.descStr = @"名字:";
        _cvvTextView.textField.placeholder = @"卡片背面三位安全码";
        _zipTextView.descStr = @"邮编:";
        _zipTextView.textField.placeholder = @"邮编";
    }
    
    height += 70;
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 45);
    _confirmBtn.backgroundColor = ButtonColor;
    [_confirmBtn setTitle:NSLocalizedString(kRecieve,nil) forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 5;
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    [self.view bringSubviewToFront:_confirmBtn];
    
    height += 60;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, height, SCREEN_WIDTH-40, 20)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor redColor];
    label.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"* %@",NSLocalizedString(kSupportCart, nil)] index:1 textColor:[UIColor lightGrayColor]];
    [self.view addSubview:label];
    
    height += 35;
    
    NSArray *imageA = @[@"visa",@"discover",@"amex",@"masterCard"];
    for (int i=0; i<4; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-(48*4+60))/2.0+68*i, height, 48, 48)];
        imageV.image = [UIImage imageNamed:imageA[i]];
        [self.view addSubview:imageV];
    }

}

- (void)confirmButtonClick{
    [self.view endEditing:YES];
    if (_cardNoTextView.textField.text.length == 0){
        [self arlertShowWithText:NSLocalizedString(kArlertCreditCardNO, nil)];
        return;
    }
    
    if (_dateTextView.textField.text.length == 0) {
        [self arlertShowWithText:NSLocalizedString(kArlertValidity, nil)];
        return;
    }
    
    if (_cvvTextView.textField.text.length == 0){
        if ([LanguageManager shareManager].language == 0) {
            [self arlertShowWithText:@"Please enter card verifycation value"];
        }else{
            [self arlertShowWithText:@"请输入卡片背面三位安全码"];
        }
        return;
    }
    
    if (_addressTextView.textField.text.length == 0){
        if ([LanguageManager shareManager].language == 0) {
            [self arlertShowWithText:@"Please enter your address"];
        }else{
            [self arlertShowWithText:@"请输入您的地址"];
        }
        return;
    }
    
    
    if (_firstNameTextView.textField.text.length == 0){
        if ([LanguageManager shareManager].language == 0) {
            [self arlertShowWithText:@"Please enter the last name"];
        }else{
            [self arlertShowWithText:@"请输入您的名字"];
        }
        return;
    }
    
    if (_lastNameTextView.textField.text.length == 0){
        if ([LanguageManager shareManager].language == 0) {
            [self arlertShowWithText:@"Please enter the first name"];
        }else{
            [self arlertShowWithText:@"请输入您的姓"];
        }
        return;
    }
    
    if (_zipTextView.textField.text.length == 0) {
        if ([LanguageManager shareManager].language == 0) {
            [self arlertShowWithText:@"Please enter the zip_code"];
        }else{
            [self arlertShowWithText:@"请输入您的邮编"];
        }
        return;
    }
    
    PaymentModel *model = [PaymentModel loadPaymentAccount];
    if (model == nil) {
        model = [[PaymentModel alloc] init];
    }
    model.userId = [UserInfoTool loadLoginAccount].user_id;

    PaymentItem *item = [[PaymentItem alloc] init];
    
    item.cardNo = _cardNoTextView.textField.text;
    item.expTime = _dateTextView.textField.text;
    item.cvv = _cvvTextView.textField.text;
    item.firstName = _firstNameTextView.textField.text;
    item.lastName = _lastNameTextView.textField.text;
    item.zipCode = _zipTextView.textField.text;
    item.address = _addressTextView.textField.text;
    
    [model.dataArray addObject:item];
    
    [PaymentModel savePamentAccount:model];
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSString *date = [self md5:_dateTextView.textField.text];
    
//    [MeServer addCreditCardWithCardNo:_cardNoTextView.textField.text date:date cvv:_cvvTextView.textField.text address:_addressTextView.textField.text firstName:_firstNameTextView.textField.text lastName:_lastNameTextView.textField.text zip_code:_zipTextView.textField.text Success:^(id result) {
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        [self errorResponsText:error];
//    }];
    
}

- (void)textFieldReturn:(UITextField *)textField textView:(CreditCardTextView *)textView{
    
}

//md5加密
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
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
