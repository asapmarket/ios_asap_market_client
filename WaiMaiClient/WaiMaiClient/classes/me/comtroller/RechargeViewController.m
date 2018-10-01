//
//  RechargeViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *rechargeLabel;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UIButton *promptlyBtn;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopBarTitle:@"充值"];
    [self initView];
}

- (void)initView{
    _rechargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(TableBorder, 230, 65, 30)];
    _rechargeLabel.font = [UIFont systemFontOfSize:15.0];
    _rechargeLabel.textColor = [UIColor hexStringToColor:@"#333333"];
    _rechargeLabel.text = @"充值金额";
    _rechargeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_rechargeLabel];
    
    _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 230, SCREEN_WIDTH-100, 30)];
    _moneyTextField.placeholder = @"请输入充值金额";
    _moneyTextField.delegate = self;
    _moneyTextField.font = [UIFont systemFontOfSize:15.0];
    _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:_moneyTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(TableBorder, 270, SCREEN_WIDTH-2*TableBorder, 1)];
    line.backgroundColor = [UIColor hexStringToColor:@"#333333"];
    [self.view addSubview:line];
    
    _promptlyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _promptlyBtn.frame = CGRectMake(10, 320, SCREEN_WIDTH-20, 45);
    [_promptlyBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [_promptlyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _promptlyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _promptlyBtn.layer.cornerRadius = 5;
    [_promptlyBtn setBackgroundColor:ButtonColor];
    [_promptlyBtn addTarget:self action:@selector(promptlyOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_promptlyBtn];
    
}

- (void)promptlyOrder{
    
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
