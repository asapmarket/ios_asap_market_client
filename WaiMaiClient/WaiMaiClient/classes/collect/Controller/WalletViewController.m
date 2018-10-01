//
//  WalletViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/12/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "WalletViewController.h"
#import "BalanceView.h"
#import "ExchangeView.h"
#import "CollectServer.h"

@interface WalletViewController ()<BalanceViewDelegate, ExchangeViewDelegate>

@property (nonatomic, strong) BalanceView *balanceView;
@property (nonatomic, strong) ExchangeView *exchangeView;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation WalletViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(kWallet, nil);
    [self setupUI];
}

- (void)setupUI{
    
    CGFloat height = TopBarHeight+15;
    
    CGFloat balanceViewH = 202;
    CGFloat exchangeViewH = 312;
    
    if (IS_IPHONE_5) {
        balanceViewH = 162;
        exchangeViewH = 252;
    }else if (IS_IPHONE_6){
        balanceViewH = 202;
        exchangeViewH = 312;
    }else if (IS_IPHONE_6P){
        balanceViewH = 202;
        exchangeViewH = 362;
    }else if (IS_IPHONE_X){
        balanceViewH = 202;
        exchangeViewH = 372;
    }
    
    _balanceView = [[BalanceView alloc] initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-20, balanceViewH)];
    _balanceView.delegate = self;
    [self.view addSubview:_balanceView];
    
    height += 217;
    if (IS_IPHONE_5) {
        height -= 40;
    }
    
    _exchangeView = [[ExchangeView alloc] initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-20, exchangeViewH)];
    _exchangeView.delegate = self;
    [self.view addSubview:_exchangeView];
    
}

- (void)loadData{
    [CollectServer getWalletPageSuccess:^(WalletModel *result) {
        if (!_balanceView) {
            [self setupUI];
        }
        _balanceView.model = result;
        _exchangeView.model = result;
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)rewardPointDidClick:(WalletModel *)model{
    NSString *message = nil;
    if ([LanguageManager shareManager].language == 0) {
        message = model.info_en;
    }else{
        message = model.info_cn;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kWhatIsRewardPoint,nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:verifyAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)exchangeButtonDidClick:(WalletModel *)model{

    [CollectServer exchangeSuccess:^(id result) {
        [self loadData];
        [self exchangeSuccessView];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)exchangeSuccessView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.view.window addSubview:_bgView];
        
        UIView *arletView = [[UIView alloc] initWithFrame:CGRectMake(10, (SCREEN_HEIGHT-178)/2.0, SCREEN_WIDTH-20, 178)];
        arletView.backgroundColor = [UIColor whiteColor];
        arletView.layer.cornerRadius = 5;
        [_bgView addSubview:arletView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-64)/2.0, 30, 44, 44)];
        imageView.image = [UIImage imageNamed:@"walletSuccess"];
        [arletView addSubview:imageView];
        
        UILabel *label = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentCenter];
        label.text = NSLocalizedString(kRewardPointSuccess, nil);
        label.frame = CGRectMake(10, 84, SCREEN_WIDTH-60, 18);
        [arletView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 178-49, SCREEN_WIDTH-20, 49);
        [btn setTitle:NSLocalizedString(kVerify, nil) forState:UIControlStateNormal];
        btn.backgroundColor = ButtonColor;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(verity) forControlEvents:UIControlEventTouchUpInside];
        [arletView addSubview:btn];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(4.5, 4.5)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        
        maskLayer.frame = btn.bounds;
        maskLayer.path = maskPath.CGPath;
        
        btn.layer.mask = maskLayer;

    }
    
}

- (void)verity{
    if (_bgView){
        [_bgView removeFromSuperview];
        _bgView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
