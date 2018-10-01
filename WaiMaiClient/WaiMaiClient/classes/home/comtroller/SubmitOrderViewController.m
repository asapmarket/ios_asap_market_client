//
//  SubmitOrderViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/9.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "TwoCell.h"
#import "CustomCell.h"
#import "CartHeaderView.h"
#import "SubmitFoodCell.h"
#import "StoreDetailViewController.h"
#import "CalculatePrice.h"
#import "StringColor.h"
#import "SCUtil.h"
#import "ShopAddrViewController.h"
#import "AddressModel.h"
#import "SelAddressCell.h"
#import "PayStyleView.h"
#import "OrderParam.h"
#import "HomeServer.h"
#import "ShopCartManager.h"
#import "OrderHtmlViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PayPalMobile.h"
#import "OederDetailViewController.h"
#import "CreditCardViewController.h"
#import "CreditCardModel.h"
#import "OrderHintCell.h"
#import "MyCreditCardViewController.h"

#import <PassKit/PassKit.h>
#import <CommonCrypto/CommonDigest.h>

#import "JKPickView.h"
#import "PaymentModel.h"

#import <Stripe/Stripe.h>

#import "WMCouponsCell.h"

#import "WMInputCouponsView.h"
#import "WMPriceCell.h"

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface SubmitOrderViewController ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate, CartHeaderViewDelegate, PayStyleViewDelegate,PKPaymentAuthorizationViewControllerDelegate, PayPalPaymentDelegate>
{
    NSMutableArray *summaryItems;
    NSMutableArray *shippingMethods;
}


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) PayStyleView *payTypeView;

@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *remark;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@property (nonatomic, assign) NSInteger applePaySuc;

@property (nonatomic, strong) WMInputCouponsView *inputCouponsView;

//是否选择地址
@property (nonatomic, assign) BOOL isAddress;

@property (nonatomic, strong) OrderResult *orderResult;

@property (nonatomic, strong) AddressModel *addrModel;
@property (nonatomic, strong) PaymentItem *cardModel;

@property (nonatomic, strong) AmoutModel *amountModel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *settlementView;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, assign) BOOL isSubmit; //支付中？  yes  未支付  no 支付中

@property (nonatomic, strong) DeliveryTimeModel *timeModel;
@property (nonatomic, strong) DeliveryTimeItem *timeItem;

@property (nonatomic, strong) NSString *coupons;

@property (nonatomic, strong) WMUserCouponsModel *couponsModel;
@end

@implementation SubmitOrderViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_payTypeView) {
        [_payTypeView removeFromSuperview];
        _payTypeView.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isSubmit = YES;
    [self isLogin];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kSubmitOrder, nil)];
    _titleArray = [NSArray arrayWithObjects:NSLocalizedString(kAppendAddress, nil), NSLocalizedString(@"DeliveryTime", nil), NSLocalizedString(@"Coupons", nil),NSLocalizedString(kSelectPayStyle, nil),NSLocalizedString(kCustomRemark, nil),@"Apple Pay", nil];
    _iconArray = [NSArray arrayWithObjects:@"location",@"deliveryTime",@"coupons", @"wallet",@"write", nil];
    _coupons = NSLocalizedString(@"UseCoupons", nil);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAddress:) name:kSelectAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCreditCard:) name:kSelectCreditCard object:nil];

    _isAddress = NO;
    [self initTableView];
    [self.tableView reloadData];
    _payType = @"10";
    _applePaySuc = 0;
    [self initData];

}

- (void)isLogin{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    if (userInfo == nil) {
        [LoginManager toLogin];
    }else{
        [self initView];
    }
}

- (void)selectCreditCard:(NSNotification *)nofi{
    _cardModel = [nofi object];
    [self.tableView reloadData];
}

- (void)selectAddress:(NSNotification *)nofi{
    _addrModel = [nofi object];
    _isAddress = YES;
    _timeModel = nil;
    _timeItem = nil;
    [self.tableView reloadData];

    [HomeServer getDeliveryTimeWithZip_code:_addrModel.zip_code success:^(DeliveryTimeModel *result) {
        _timeModel = result;
        if(_timeModel.rows.count > 0){
            _timeItem = _timeModel.rows[0];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)initData{
    
    OrderUpBaseModel *upParam = [OrderParam getOrderParamWithCartBaseModel:_baseModel patType:_payType remark:_remark ectmId:_addrModel.extm_id distribution_time:_timeItem.distribution_time];
    
    [HomeServer getOrderTotalMoneyWithParam:upParam Success:^(AmoutModel *result) {
        _amountModel = result;
        if (_amountModel.store_ids.count > 0){
            NSString *message;
            if ([LanguageManager shareManager].language == 0) {
                message = [NSString stringWithFormat:@"%@ it's closed, please resubmit your shopping cart",result.store_name_en];
            }else{
                message = [NSString stringWithFormat:@"%@已经打烊,请重新提交您的购物车",result.store_name_cn];
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kBack,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:verifyAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        if (_amountModel.default_address) {
            _addrModel = _amountModel.default_address;
            _isAddress = YES;
            [HomeServer getDeliveryTimeWithZip_code:_addrModel.zip_code success:^(DeliveryTimeModel *result) {
                _timeModel = result;
                if(_timeModel.rows.count > 0){
                    _timeItem = _timeModel.rows[0];
                    [self.tableView reloadData];
                }
            } failure:^(NSError *error) {
                [self errorResponsText:error];
            }];
        }
        [self.tableView reloadData];
        NSString *message;
        if ([LanguageManager shareManager].language == 0) {
            message = result.count_words_en;
        }else{
            message = result.count_words_cn;
        }
        if ([result.money_limit isEqualToString:@"0"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kContinue,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kBack,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:verifyAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-49-TopBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)initView{
    if (!_submitButton) {
        _submitButton = [CreateButton initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49) title:NSLocalizedString(kSubmit, nil) titleColor:[UIColor whiteColor] target:self action:@selector(submitButtonClick)];
        _submitButton.layer.cornerRadius = 0;
        [_submitButton setBackgroundColor:ButtonColor];
        [self.view addSubview:_submitButton];
        [self.view bringSubviewToFront:_submitButton];

    }
    
    __weak typeof(self) weakSelf = self;
    
    if (!_inputCouponsView) {
        _inputCouponsView = [[WMInputCouponsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _inputCouponsView.hidden = YES;
        _inputCouponsView.cancelButtonClickBlock = ^(WMInputCouponsView *couponsView) {
            weakSelf.inputCouponsView.hidden = YES;
        };
        
        _inputCouponsView.verifyButtonClickBlock = ^(WMInputCouponsView *couponsView, UITextField *textField) {
            couponsView.hidden = YES;
            WMUserCouponsParam *param = [[WMUserCouponsParam alloc] init];
            param.COUPON_NUM = textField.text;
            param.yunfei = weakSelf.amountModel.yunfei;
            param.tax = weakSelf.amountModel.tax;
            param.total_money = weakSelf.amountModel.total_money;
            param.user_id  = [UrlsManager userID];
            param.token = [UrlsManager token];
            [HomeServer postUserCouponsWithParam:param success:^(WMUserCouponsModel *result) {
                weakSelf.couponsModel = result;
                weakSelf.coupons = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"DiscountAmount", nil), result.COUPON_MONEY];
                [weakSelf.tableView reloadData];
            } failure:^(NSError *error) {
                [weakSelf errorResponsText:error];
            }];
            
        };
        
        _inputCouponsView.endEditBlock = ^(WMInputCouponsView *couponsView, UITextField *textField) {
            if (!couponsView.hidden) {
                couponsView.hidden = YES;
            }
        };
        [self.view addSubview:_inputCouponsView];
        [self.view bringSubviewToFront:_inputCouponsView];
    }
    
}

- (void)submitButtonClick{
    
    if (!_isSubmit) {
        [self arlertShowWithText:NSLocalizedString(@"InThePayment", nil)];
        return;
    }
    if (!_addrModel) {
        [self arlertShowWithText:NSLocalizedString(kAppendAddress, nil)];
        return;
    }
    if ([_payType isEqualToString:@"10"]) {
        [self arlertShowWithText:NSLocalizedString(kSelectPayStyle, nil)];
        return;
    }
    
    if ([_payType isEqualToString:@"3"] && !_cardModel){
        [self arlertShowWithText:NSLocalizedString(kSelectPayStyle, nil)];
        return;
    }
    _isSubmit = NO;
    OrderUpBaseModel *upParam = [OrderParam getOrderParamWithCartBaseModel:_baseModel patType:_payType remark:_remark ectmId:_addrModel.extm_id distribution_time:_timeItem.distribution_time];
    if (_couponsModel) {
        upParam.COUPON_NUM = _couponsModel.COUPON_NUM;
        upParam.COUPON_MONEY = _couponsModel.COUPON_MONEY;
    }
    [HomeServer getCreatOrderUrlWithParam:upParam Success:^(OrderResult *result) {
        NSLog(@"%@",result);
        if (result.store_ids.count > 0){
            NSString *message;
            if ([LanguageManager shareManager].language == 0) {
                message = [NSString stringWithFormat:@"%@ it's closed, please resubmit your shopping cart",result.store_name_en];
            }else{
                message = [NSString stringWithFormat:@"%@已经打烊,请重新提交您的购物车",result.store_name_cn];
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kBack,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:verifyAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        _orderResult = result;
        PayParam *param = [[PayParam alloc] init];
        param.order_id = result.order_id;
        if ([_payType isEqualToString:@"2"]) {
            [self applePayAction];
        }else if ([_payType isEqualToString:@"3"]){
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
                        cardParam.order_id = result.order_id;
                        cardParam.stripe_token = token.tokenId;
                        cardParam.order_type = @"0";
                        
                        [HomeServer postCreditCardResultWithParam:cardParam Success:^(id result) {
                            NSLog(@"%@",result);
                            _isSubmit = YES;
                            [[ShopCartManager shareManager] clearShopCart];
                            OederDetailViewController *orderDetail = [[OederDetailViewController alloc] init];
                            orderDetail.isPay = YES;
                            orderDetail.orderId = _orderResult.order_id;
                            [self.navigationController pushViewController:orderDetail animated:YES];
                            
                        } failure:^(NSError *error) {
                            _isSubmit = YES;
                            [self errorResponsText:error];
                        }];
                    }else{
                        [self arlertShowWithText:@"pay error"];
                    }
                   
                }];
               

            }
        }else if ([_payType isEqualToString:@"4"] || [_payType isEqualToString:@"5"]){
            _isSubmit = YES;
            [[ShopCartManager shareManager] clearShopCart];
            OederDetailViewController *orderDetail = [[OederDetailViewController alloc] init];
            orderDetail.isPay = YES;
            orderDetail.orderId = _orderResult.order_id;
            [self.navigationController pushViewController:orderDetail animated:YES];
        }else if ([_payType isEqualToString:@"1"]){
            [self payPalAction];
        }
        
    } failure:^(NSError *error) {
        _isSubmit = YES;
        [self errorResponsText:error];

    }];
}


- (void)setBaseModel:(MyShopCartBaseModel *)baseModel{
    _baseModel = baseModel;
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 1;
    }else if (section == _baseModel.dataArray.count + 2){
        return 1;
    }else{
        MyShopCartSection *sectionModel = _baseModel.dataArray[section-2];
        return sectionModel.food_list.count;
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _baseModel.dataArray.count + 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return 80;
        }else if(indexPath.row == 0){
            if (_isAddress) {
                return 75;
            }else{
                return 55;
            }
        }else if (indexPath.row == 1){
            if (_timeItem) {
                return 55;
            }else{
                return 0;
            }
        }else{
            return 55;
        }
    }else if (indexPath.section == 1){
        if ([LanguageManager shareManager].language == 0){
            return 150;
        }else{
            return 110;
        }
    }else if (indexPath.section == _baseModel.dataArray.count + 2){
        if (_couponsModel) {
            return 123;
        }else{
            return 100;
        }
    }else{
        return 40;
    }
}

static NSString *TwoCellId = @"TwoCellId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        if (indexPath.row == 0) {
            if (_isAddress) {
                SelAddressCell *selAddRCell = [tableView dequeueReusableCellWithIdentifier:@"AddressCellId"];
                if (selAddRCell == nil) {
                    selAddRCell = [[SelAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressCellId"];
                }
                selAddRCell.line.hidden = NO;
                [selAddRCell setModel:_addrModel];
                return selAddRCell;
            }else{
                TwoCell *two = [tableView dequeueReusableCellWithIdentifier:TwoCellId];
                if (two == nil) {
                    two = [[TwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellId];
                }
                [two setTitle:_titleArray[indexPath.row] icon:_iconArray[indexPath.row]];
                return two;
            }
        }else if (indexPath.row == 1){
            if(_timeItem){
                TwoCell *two = [tableView dequeueReusableCellWithIdentifier:@"TimeCellID"];
                if (two == nil) {
                    two = [[TwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeCellID"];
                }
                [two setTitle:_titleArray[indexPath.row] icon:_iconArray[indexPath.row]];
                if (_timeItem) {
                    [two setTime:_timeItem.distribution_time];
                }else{
                    [two setTime:@""];
                }
                return two;
            }
            
        }else if (indexPath.row == 2){
            
            WMCouponsCell *couponsCell = [tableView dequeueReusableCellWithIdentifier:@"couponsID"];
            if (couponsCell == nil) {
                couponsCell = [[WMCouponsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"couponsID"];
            }
            [couponsCell setCoupons:_coupons];
            return couponsCell;
        }else if (indexPath.row == 3){
            TwoCell *two = [tableView dequeueReusableCellWithIdentifier:TwoCellId];
            if (two == nil) {
                two = [[TwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellId];
            }
            NSString *title;
            
            if ([_payType isEqualToString:@"0"]) {
                title = @"visa";
            }else if ([_payType isEqualToString:@"1"]){
                title = @"paypal";
            }else if ([_payType isEqualToString:@"2"]){
                title = @"Apple Pay";
            }else if([_payType isEqualToString:@"3"]){
                if (_cardModel) {
                    title = [NSString stringWithFormat:@"**** **** **** %@",[_cardModel.cardNo substringWithRange:NSMakeRange(_cardModel.cardNo.length-4, 4)]];
                }else{
                    title = NSLocalizedString(kPayWithCard, nil);
                }
            }else if ([_payType isEqualToString:@"4"]){
                title = NSLocalizedString(kCashPayments, nil);
            }else if ([_payType isEqualToString:@"5"]){
                title = NSLocalizedString(kRewardPointPay, nil);
            }
            else{
                title = NSLocalizedString(kSelectPayStyle, nil);
            }
            [two setTitle:title icon:_iconArray[indexPath.row]];
            return two;
        }else{
            CustomCell *custom = [CustomCell cellWithTableView:tableView];
            custom.customTextView.text = _titleArray[4];
            custom.customTextView.delegate = self;
            return custom;
        }
    }else if (indexPath.section == 1){
        OrderHintCell *hintCell = [tableView dequeueReusableCellWithIdentifier:@"HintCellId"];
        if(hintCell == nil){
            hintCell = [[OrderHintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HindCellId"];
        }
        return hintCell;
        
    }else if (indexPath.section == _baseModel.dataArray.count + 2){
        if (_amountModel) {
            WMPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:@"WMPriceCellID"];
            if (priceCell == nil) {
                priceCell = [[WMPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WMPriceCellID"];
            }
            if (_couponsModel) {
                [priceCell setCouponsModel:_couponsModel];
            }else{
                [priceCell setModel:_amountModel];
            }
            return priceCell;
        }
    }else{
        NSUInteger section = indexPath.section;
        NSInteger r = indexPath.row;
        MyShopCartSection *sectionModel = _baseModel.dataArray[section-2];
        FoodsListModel *listModel = sectionModel.food_list[r];
        SubmitFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubmitFoodCellId"];
        if (cell == nil) {
            cell = [[SubmitFoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubmitFoodCellId"];
        }
        [cell setListModel:listModel];
        
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == _baseModel.dataArray.count +2){
        return 1;
    }else if (section == 0 || section == 1) {
        return 0.1;
    }else{
        return 59;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 10;
    }else{
        return 5;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >= 2 && section != _baseModel.dataArray.count + 2) {
        MyShopCartSection *sectionModel = _baseModel.dataArray[section-2];
        CartHeaderView *view = [[CartHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
        view.backgroundColor = [UIColor whiteColor];
        view.isSubmit = YES;
        view.delegate = self;
        [view setSection:sectionModel];
        return view;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ShopAddrViewController *shopAdr = [[ShopAddrViewController alloc] init];
            shopAdr.isSelAddr = YES;
            [self.navigationController pushViewController:shopAdr animated:YES];
        }else if (indexPath.row == 3){
            _payTypeView = [[PayStyleView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
            _payTypeView.delegate = self;
            _payTypeView.payType = _payType;
            _payTypeView.rewardP = _amountModel.point_balance;
            [self.view addSubview:_payTypeView];
            [self.view bringSubviewToFront:_payTypeView];
        }else if (indexPath.row == 1){
            __weak typeof(self) weakSelf = self;
            if(_timeModel.rows.count > 0){
                NSLog(@"====%ld",(long)_timeModel.rows.count);
                NSMutableArray *array = [NSMutableArray array];
                for (int i=0; i<_timeModel.rows.count; i++) {
                    DeliveryTimeItem *item = _timeModel.rows[i];
                    [array addObject:item.distribution_time];
                }
                JKPickView *pickview = [JKPickView new];
                [pickview.dataArray addObjectsFromArray:array];
                pickview.selectedRow = @"0";
                pickview.back = ^(NSInteger row) {
                    NSLog(@"%ld",(long)row);
                    weakSelf.timeItem = weakSelf.timeModel.rows[row];
                    [weakSelf.tableView reloadData];
                };
            }
        }else if (indexPath.row == 2){
            if (_inputCouponsView.hidden) {
                _inputCouponsView.hidden = NO;
                [self.view addSubview:_inputCouponsView];
                [self.view bringSubviewToFront:_inputCouponsView];
            }
        }
    }
}


- (void)leftSelectButtonClick:(MyShopCartSection *)sectionModel{
    
}

- (void)headerViewDidTap:(MyShopCartSection *)sectionModel{
    
}

- (void)payStyleClickReturn:(NSString *)tyle{
    NSLog(@"type = %@",tyle);
    _payType = tyle;
    if ([_payType isEqualToString:@"3"]) {
        MyCreditCardViewController *creditCard = [[MyCreditCardViewController alloc] init];
        creditCard.isSelCD = YES;
        [self.navigationController pushViewController:creditCard animated:YES];
    }else{
        [self.tableView reloadData];
    }
    
    [_payTypeView removeFromSuperview];
    _payTypeView.delegate = nil;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:NSLocalizedString(@"CustomRemark", nil)]) {
        textView.text = @"";
        textView.textColor = RGB(51, 51, 51);
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if([text isEqualToString:@"\n"])
        
    {
        [textView resignFirstResponder];
        return NO;
        
    }
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    _remark = textView.text;
}

#pragma Paypal

- (void)payPalAction{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
    NSDecimalNumber *total = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%.2f",[_orderResult.money doubleValue]]];
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
    [dict setValue:_orderResult.order_id forKeyPath:@"order_id"];
    
    [HomeServer postPayPayResultWithDict:dict Success:^(NSString *result) {
        NSLog(@"%@",result);
        [self dismissViewControllerAnimated:YES completion:nil];
        [[ShopCartManager shareManager] clearShopCart];
        OederDetailViewController *orderDetail = [[OederDetailViewController alloc] init];
        orderDetail.isPay = YES;
        orderDetail.orderId = _orderResult.order_id;
        [self.navigationController pushViewController:orderDetail animated:YES];

    } failure:^(NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self errorResponsText:error];
    }];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_orderResult.order_id forKeyPath:@"order_id"];
    [HomeServer postPayPayResultWithDict:dict Success:^(NSString *result) {
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Apple Pay

-(void)applePayAction
{
    if (![PKPaymentAuthorizationViewController class]) {
        [self arlertShowWithText:NSLocalizedString(kNotAllowApplePay, nil)];
        return;
    }
    if (![PKPaymentAuthorizationViewController canMakePayments]) {
        [self arlertShowWithText:NSLocalizedString(kNotAllowApplePay, nil)];
        return;
    }
    NSArray *supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkChinaUnionPay, PKPaymentNetworkDiscover, PKPaymentNetworkInterac, PKPaymentNetworkMasterCard, PKPaymentNetworkPrivateLabel, PKPaymentNetworkVisa, PKEncryptionSchemeECC_V2];
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
        [self arlertShowWithText:NSLocalizedString(kNotAllowApplePay, nil)];
        return;
    }
    PKPaymentRequest *payRequest = [[PKPaymentRequest alloc]init];
    payRequest.countryCode = @"US";     //国家代码 CN
    payRequest.currencyCode = @"USD";       //RMB的币种代码 CNY
    payRequest.merchantIdentifier = @"merchant.com.mhysa.waimai";  //申请的merchantID
    payRequest.supportedNetworks = supportedNetworks;
    //用户可进行支付的银行卡
    payRequest.merchantCapabilities = PKMerchantCapabilityDebit | PKMerchantCapabilityCredit | PKMerchantCapabilityEMV;
    
    payRequest.paymentSummaryItems = summaryItems;
    
    NSDecimalNumber *subtotalAmount = [NSDecimalNumber decimalNumberWithString:_orderResult.money];
    PKPaymentSummaryItem *subtotal = [PKPaymentSummaryItem summaryItemWithLabel:NSLocalizedString(kTotal, nil) amount:subtotalAmount];
    
    
    NSDecimalNumber *totalAmount = [NSDecimalNumber zero];
    totalAmount = [totalAmount decimalNumberByAdding:subtotalAmount];
    PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:NSLocalizedString(kMerchant, nil) amount:totalAmount];
    
    summaryItems = [NSMutableArray arrayWithArray:@[subtotal, total]];
    
    payRequest.paymentSummaryItems = summaryItems;
    
    
    //ApplePay控件
    PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:payRequest];
    paymentPane.delegate = self;
    if (!paymentPane) {
        [self arlertShowWithText:NSLocalizedString(kNotAllowApplePay, nil)];
    } else {
        // 模态推出页面
        [self presentViewController:paymentPane animated:YES completion:nil];
    }
}
#pragma mark - PKPaymentAuthorizationViewControllerDelegate
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                  didSelectShippingContact:(PKContact *)contact
                                completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion{
    
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                   didSelectShippingMethod:(PKShippingMethod *)shippingMethod
                                completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion{
    
}
-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectPaymentMethod:(PKPaymentMethod *)paymentMethod completion:(void (^)(NSArray<PKPaymentSummaryItem *> * _Nonnull))completion{
    //支付银行卡回调，如果需要根据不同的银行调整付费金额，可以实现该代理
    completion(summaryItems);
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion {
    
    PKPaymentToken *payToken = payment.token;
    //支付凭据，发给服务端进行验证支付是否真实有效
    
    id result = [NSJSONSerialization JSONObjectWithData:payToken.paymentData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",payToken.paymentData.mj_keyValues);
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    
    if ([result isKindOfClass:[NSDictionary class]]){
        [result setObject:_orderResult.order_id forKey:@"order_id"];
        [result setObject:userInfo.user_id forKey:@"user_id"];
        [result setObject:userInfo.token forKey:@"token"];
    }
    
    [HomeServer postApplePayResultWithDict:result Success:^(NSString *result) {
        if ([result isEqualToString:@"success"]) {
            completion(PKPaymentAuthorizationStatusSuccess);
            _applePaySuc = 1;
        }else{
            completion(PKPaymentAuthorizationStatusFailure);
            _applePaySuc = 2;
        }
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    _isSubmit = YES;
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (_applePaySuc == 1) {
        [[ShopCartManager shareManager] clearShopCart];

        OederDetailViewController *orderDetail = [[OederDetailViewController alloc] init];
        orderDetail.isPay = YES;
        orderDetail.orderId = _orderResult.order_id;
        [self.navigationController pushViewController:orderDetail animated:YES];
    }else if (_applePaySuc == 2){
        [self arlertShowWithText:NSLocalizedString(kPayFail, nil)];
    }else{
        [self arlertShowWithText:NSLocalizedString(kPayCancle, nil)];
    }
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
