//
//  MyWalletViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyWalletViewController.h"
#import "RechargeViewController.h"

@interface MyWalletViewController ()

@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *balaceLabel;   //余额
@property (nonatomic, strong) UIButton *rechargeBtn;  //充值
@property (nonatomic, strong) UIButton *depositBtn;  //提现

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:@"我的钱包"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}

- (void)initView{
    
    _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(TableBorder, 155, SCREEN_WIDTH-2*TableBorder, 13)];
    _desLabel.font = [UIFont systemFontOfSize:15.0];
    _desLabel.textAlignment = NSTextAlignmentCenter;
    _desLabel.textColor = [UIColor hexStringToColor:@"#333333"];
    _desLabel.text = @"账户余额";
    [self.view addSubview:_desLabel];
    
    _balaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(TableBorder, 188, SCREEN_WIDTH-2*TableBorder, 26)];
    _balaceLabel.font = [UIFont systemFontOfSize:30.0];
    _balaceLabel.textAlignment = NSTextAlignmentCenter;
    _balaceLabel.textColor = [UIColor hexStringToColor:@"#333333"];
    _balaceLabel.text = @"$100000.00";
    [self.view addSubview:_balaceLabel];
    
    _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rechargeBtn.frame = CGRectMake(TableBorder, 266, SCREEN_WIDTH-2*TableBorder, 45.5);
    _rechargeBtn.layer.cornerRadius = 5;
    [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    _rechargeBtn.backgroundColor = ButtonColor;
    [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rechargeBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rechargeBtn];
    
    _depositBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _depositBtn.frame = CGRectMake(TableBorder, 330, SCREEN_WIDTH-2*TableBorder, 45.5);
    _depositBtn.layer.cornerRadius = 5;
    [_depositBtn setTitle:@"提现" forState:UIControlStateNormal];
    _depositBtn.backgroundColor = [UIColor whiteColor];
    [_depositBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
    [_depositBtn.layer setMasksToBounds:YES];
    [_depositBtn.layer setCornerRadius:5.0]; //设置矩圆角半径
    [_depositBtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 33/255.0, 150/255.0, 233/255.0, 1 });
    [_depositBtn.layer setBorderColor:colorref];//边框颜色
//    [_depositBtn addTarget:self action:@selector(deposit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_depositBtn];
    
}

- (void)recharge{
    RechargeViewController *recharge = [[RechargeViewController alloc] init];
    [self.navigationController pushViewController:recharge animated:YES];
    
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
