//
//  MyCreditCardViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/9/19.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyCreditCardViewController.h"
#import "CreditCardViewController.h"
#import "MeServer.h"
#import "CreditCardCell.h"
#import "PaymentModel.h"

@interface MyCreditCardViewController ()<CreditCardCellDelegate>


@property (nonatomic, strong) PaymentModel *model;

@end

@implementation MyCreditCardViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kMyCreditCard, nil) rightImage:@"add"];
    self.canLoadMore = NO;
}

- (void)rightButtonAction{
    CreditCardViewController *addCD = [[CreditCardViewController alloc] init];
    [self.navigationController pushViewController:addCD animated:YES];
}

- (void)initData{

    _model = [PaymentModel loadPaymentAccount];
    
    if (![_model.userId isEqualToString:[UserInfoTool loadLoginAccount].user_id]) {
        [PaymentModel savePamentAccount:nil];
        [_model.dataArray removeAllObjects];
    }
    self.dataArray = _model.dataArray;
    [self.tableView reloadData];
}

- (void)setIsSelCD:(BOOL)isSelCD{
    _isSelCD = isSelCD;
    if (_isSelCD) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma UITableViewDelegate
static NSString *MyCreditCardId = @"MyCreditCardId";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 169;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CreditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCreditCardId];
    if (cell == nil) {
        cell = [[CreditCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCreditCardId];
    }
    cell.delegate = self;
    cell.model = self.dataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PaymentItem *model = self.dataArray[indexPath.section];
    if (_isSelCD) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSelectCreditCard object:model];
        [self.navigationController popViewControllerAnimated:YES];
    }    
}

- (void)deleteButtonClick:(CreditCardModel *)model{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(KVerifyDelete,nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [_model.dataArray removeObject:model];
        [PaymentModel savePamentAccount:_model];
        [self.tableView reloadData];
        
//        [MeServer deletaCreditCardWithID:model.cardId Success:^(id result) {
//            [self initData];
//        } failure:^(NSError *error) {
//            [self errorResponsText:error];
//        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:verifyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

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
