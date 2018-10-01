//
//  MineViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MineViewController.h"
#import "SetPersonalViewController.h"
#import "PersonalCell.h"
#import "oneCell.h"
#import "TwoCell.h"
#import "MyWalletViewController.h"
#import "MyMessageViewController.h"
#import "ShopAddrViewController.h"
#import "IndentViewController.h"
#import "MyCreditCardViewController.h"
#import "ContactUsViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isLogin];
    [[ShopCartManager shareManager] setShopCartCount:[SCUtil getGoodsCount]];;
}

- (void)isLogin{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    if (userInfo == nil) {
        [LoginManager toLogin];
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kVipCenter, nil) rightImage:@"set"];
    _titleArray = [NSArray arrayWithObjects:NSLocalizedString(kAhippingAddress, nil),NSLocalizedString(kVipMessage, nil), NSLocalizedString(kHitoryOrder, nil), NSLocalizedString(kMyCreditCard, nil),nil];
    _iconArray = [NSArray arrayWithObjects:@"location",@"message",@"history_order", @"card", nil];
    
    [self initTableView];
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-TopBarHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)rightButtonAction{
    SetPersonalViewController *personalCtrl = [[SetPersonalViewController alloc] init];
    [self.navigationController pushViewController:personalCtrl animated:YES];
}


static NSString *OrderCellId = @"OrderCellId";
static NSString *PersonCellId = @"PersonCellId";
static NSString *TwoCellId = @"TwoCellId";

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 160;
    }else{
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (indexPath.row == 0){
        PersonalCell *personalCell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonCellId];
        
        cell = personalCell;
    }else if (indexPath.row == 1){
        oneCell *order = [tableView dequeueReusableCellWithIdentifier:OrderCellId];
        if (order == nil) {
            order = [[oneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderCellId];
        }
        [order setTitle:_titleArray[indexPath.row-1] icon:_iconArray[indexPath.row-1]];
        cell = order;
    }else if (indexPath.row == 5){
        oneCell *one = [tableView dequeueReusableCellWithIdentifier:OrderCellId];
        if (one == nil) {
            one = [[oneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderCellId];
        }
        [one setTitle:NSLocalizedString(kContactUs, nil) icon:@"call"];
        cell = one;
    }else{
        TwoCell *two = [tableView dequeueReusableCellWithIdentifier:TwoCellId];
        if (two == nil) {
            two = [[TwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellId];
        }
        [two setTitle:_titleArray[indexPath.row-1] icon:_iconArray[indexPath.row-1]];
        cell = two;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:{
            ShopAddrViewController *shopAdr = [[ShopAddrViewController alloc] init];
            shopAdr.isSelAddr = NO;
            [self.navigationController pushViewController:shopAdr animated:YES];
        }
            break;
        case 2:{
            MyMessageViewController *msgCtrl = [[MyMessageViewController alloc] init];
            [self.navigationController pushViewController:msgCtrl animated:YES];
        }
            break;
        case 3:{
            IndentViewController *indentCtrl = [[IndentViewController alloc] init];
            indentCtrl.navTitle = NSLocalizedString(kHitoryOrder, nil);
            [self.navigationController pushViewController:indentCtrl animated:YES];
        }
            break;
        case 4:{
            MyCreditCardViewController *creditCard = [[MyCreditCardViewController alloc] init];
            creditCard.isSelCD = NO;
            [self.navigationController pushViewController:creditCard animated:YES];
        }
            break;
        case 5:{
            ContactUsViewController *contact = [[ContactUsViewController alloc] init];
            [self.navigationController pushViewController:contact animated:YES];
        }
        default:
            break;
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
