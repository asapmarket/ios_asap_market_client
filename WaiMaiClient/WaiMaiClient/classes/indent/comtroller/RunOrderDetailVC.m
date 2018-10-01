//
//  RunOrderDetailVC.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/19.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderDetailVC.h"
#import "OrderDetailHeaderCell.h"
#import "CourierLocationCell.h"
#import "OrderServer.h"
#import "RunOrderDetailParam.h"
#import "RunOrderDetailModel.h"
#import "RunOrderGoodsDetailCell.h"
#import "RunPriceCell.h"
#import "PayPalMobile.h"
#import "PayStyleView.h"
#import <QuartzCore/QuartzCore.h>
#import <PassKit/PassKit.h>
#import "HomeServer.h"
#import "RunOrderStateParam.h"
#import "MyCreditCardViewController.h"
#import "CreditCardModel.h"
#import "StringHeight.h"

#import "RunBigImageViewLook.h"
#import "PaymentModel.h"

#import <Stripe/Stripe.h>

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface RunOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource, PayStyleViewDelegate,PKPaymentAuthorizationViewControllerDelegate, PayPalPaymentDelegate>

@property (nonatomic, strong) RunOrderDetailParam *param;
@property (nonatomic, strong) RunOrderDetailModel *model;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PayStyleView *payTypeView;

@property (nonatomic, strong) NSString *payType;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@property (nonatomic, assign) BOOL isSubmit; //支付中？  yes  未支付  no 支付中

@property (nonatomic, strong) PaymentItem *cardModel;

@property (nonatomic, assign) double userPoint;

@end

@implementation RunOrderDetailVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_payTypeView) {
        [_payTypeView removeFromSuperview];
        _payTypeView.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kIndentDetail, nil)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCreditCard:) name:kSelectCreditCard object:nil];

    [self initData];
    [self initView];

}

- (void)selectCreditCard:(NSNotification *)nofi{
    _cardModel = [nofi object];
    if (_cardModel) {
        STPCardParams *param = [[STPCardParams alloc] init];
        param.number = _cardModel.cardNo;
        if (_cardModel.expTime.length >= 4){
            param.expYear = [[_cardModel.expTime substringWithRange:NSMakeRange(_cardModel.expTime.length-2, 2)] integerValue];
            param.expMonth = [[_cardModel.expTime substringWithRange:NSMakeRange(0, 2)] integerValue];
        }
        param.cvc = _cardModel.cvv;
        [[STPAPIClient sharedClient] createTokenWithCard:param completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
            NSLog(@"%@    %@",token, error);
            if (!error) {
                CreditCardParam *cardParam = [[CreditCardParam alloc] init];
                cardParam.order_id = _model.order_id;
                cardParam.stripe_token = token.tokenId;
                cardParam.order_type = @"1";
                
                [HomeServer postCreditCardResultWithParam:cardParam Success:^(id result) {
                    NSLog(@"%@",result);
                    [self initData];
                } failure:^(NSError *error) {
                    _isSubmit = YES;
                    [self errorResponsText:error];
                }];
            }else{
                [self arlertShowWithText:@"pay error"];
            }
            
        }];
        
        
    }
    
    [self.tableView reloadData];
}

- (void)initData{
    _param = [[RunOrderDetailParam alloc] init];
    _param.user_id = [UrlsManager userID];
    _param.order_id = _order_id;
    _param.token = [UrlsManager token];
    
    [OrderServer postRunOrderDeatailListWithParam:_param success:^(RunOrderDetailModel *result) {
        _model = result;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)initView{
    CGFloat height = 49;
    if (SCREEN_HEIGHT == 812){
        height = 60;
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height);
    refreshBtn.backgroundColor = ButtonColor;
    [refreshBtn setTitle:NSLocalizedString(kRefreshLocation,nil) forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    [self.view bringSubviewToFront:refreshBtn];
    
    
}

- (void)refreshButtonClick{
    [self initData];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_model) {
        if ([_model.state integerValue] >= 3) {
            return 4;
        }
        return 3;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_model.state integerValue] >= 3){
        if (indexPath.row == 0) {
            return 155;
        }else if (indexPath.row == 1){
            CGFloat remarkH = [StringHeight heightFromString:_model.remark withFont:15 constraintToWidth:SCREEN_WIDTH-20];

            return 220+remarkH;
        }else if (indexPath.row == 2){
            return 143;
        }else{
            return 285;
        }
    }else{
        if (indexPath.row == 0) {
            return 155;
        }else if (indexPath.row == 1){
            CGFloat remarkH = [StringHeight heightFromString:_model.remark withFont:15 constraintToWidth:SCREEN_WIDTH-20];
            
            return 265+remarkH;
            
        }else{
            return 285;
        }
    }
    
}

static NSString *HeadCellID = @"HeadCellID";
static NSString *StoreCellID = @"StoreCellID";
static NSString *FooterCellID = @"FooterCellID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        OrderDetailHeaderCell *headerCell = [tableView cellForRowAtIndexPath:indexPath];
        if (headerCell == nil){
            headerCell = [[OrderDetailHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeadCellID];
        }
        [headerCell setType:1];
        [headerCell setRunModel:_model];
        
        return headerCell;
    }else if(indexPath.row == 1){
        RunOrderGoodsDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"RunOrderGoodsDetailCellID"];
        if (detailCell == nil) {
            detailCell = [[RunOrderGoodsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RunOrderGoodsDetailCellID"];
        }
        [detailCell setDetailModel:_model];
        if ([_model.state integerValue] >=3 ) {
            detailCell.promptLabel.hidden = YES;
        }else{
            detailCell.promptLabel.hidden = NO;
        }
        detailCell.imageViewDidTouchBlock = ^(RunOrderDetailModel *detailModel) {
            RunBigImageViewLook *bigImage = [[RunBigImageViewLook alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [bigImage setDetailModel:detailModel];
            [weakSelf.view.window addSubview:bigImage];
        };
        return detailCell;
    }else if ([_model.state integerValue] >= 3){
        if (indexPath.row == 2) {
            RunPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:@"RunPriceCellID"];
            if (priceCell == nil) {
                priceCell = [[RunPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RunPriceCellID"];
            }
            [priceCell setDetailModel:_model];
            priceCell.cancelButtonBlock = ^(RunOrderDetailModel *detailModel) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ConfirmCancelOrder", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"verify",nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                    RunOrderStateParam *stateParam = [[RunOrderStateParam alloc] init];
                    stateParam.order_id = _order_id;
                    stateParam.state = @"9";
                    [OrderServer postRunOrderStateWitahParam:stateParam success:^(id result) {
                        NSLog(@"postRunOrderStateWitahParam = %@",result);
                        [self initData];
                    } failure:^(NSError *error) {
                        [self errorResponsText:error];
                    }];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:verifyAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            };
            priceCell.paymentButtonBlock = ^(RunOrderDetailModel *detailModel) {

                _payTypeView = [[PayStyleView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
                _payTypeView.delegate = self;
                _payTypeView.payType = _payType;
                _payTypeView.rewardP = _model.point;
                [self.view addSubview:_payTypeView];
                [self.view bringSubviewToFront:_payTypeView];
            };
            return priceCell;
        }else{
            CourierLocationCell *locationCell = [tableView dequeueReusableCellWithIdentifier:FooterCellID];
            if (locationCell == nil) {
                locationCell = [[CourierLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FooterCellID];
            }
            [locationCell setRunModel:_model];
            return locationCell;
        }
    }else{
        CourierLocationCell *locationCell = [tableView dequeueReusableCellWithIdentifier:FooterCellID];
        if (locationCell == nil) {
            locationCell = [[CourierLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FooterCellID];
        }
        [locationCell setRunModel:_model];
        return locationCell;
    }
}

- (void)payStyleClickReturn:(NSString *)tyle{
    NSLog(@"type = %@",tyle);
    _payType = tyle;
    if ([_payType isEqualToString:@"1"]){
        if (_model.total_money) {
            [self payPalAction];
        }
    }
    if ([_payType isEqualToString:@"3"]) {
        MyCreditCardViewController *creditCard = [[MyCreditCardViewController alloc] init];
        creditCard.isSelCD = YES;
        [self.navigationController pushViewController:creditCard animated:YES];
    }else if ([_payType isEqualToString:@"4"] || [_payType isEqualToString:@"5"]){
        RunPayParam *payParan = [[RunPayParam alloc] init];
        payParan.order_id = _order_id;
        payParan.payment_method = _payType;
        [OrderServer postRunMoneyPayWithParam:payParan success:^(id result) {
            [self arlertShowWithText:NSLocalizedString(@"paySuccess", nil)];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
    
    [_payTypeView removeFromSuperview];
    _payTypeView.delegate = nil;
}


#pragma Paypal

- (void)payPalAction{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    //    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
    NSDecimalNumber *total = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%.2f",[_model.total_money doubleValue]]];
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = NSLocalizedString(kTotal, nil);
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!  %@",completedPayment.mj_keyValues);
    
    NSDictionary *dict = completedPayment.mj_keyValues;
    [dict setValue:_order_id forKeyPath:@"order_id"];
    
    [OrderServer postRunOrderPaypalWithDict:dict success:^(id result) {
        [_payTypeView removeFromSuperview];
        _payTypeView.delegate = nil;
        [self initData];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_order_id forKeyPath:@"order_id"];
    [OrderServer postRunOrderPaypalWithDict:dict success:^(id result) {
        [_payTypeView removeFromSuperview];
        _payTypeView.delegate = nil;
        [self initData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
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
