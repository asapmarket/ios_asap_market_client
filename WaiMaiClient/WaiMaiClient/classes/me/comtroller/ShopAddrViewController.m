//
//  ShopAddrViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopAddrViewController.h"
#import "UIBarButtonItem+MJ.h"
#import "AddressModel.h"
#import "AddressCell.h"
#import "AddAddressViewController.h"
#import "MeServer.h"

@interface ShopAddrViewController ()<AddressCellDelegate>


@end

@implementation ShopAddrViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kRecieveAddress, nil) rightImage:@"add"];
    self.canLoadMore = NO;
}

- (void)rightButtonAction{
    AddAddressViewController *addAddr = [[AddAddressViewController alloc] init];
    addAddr.navTitle = NSLocalizedString(kAddAddress, nil);
    [self.navigationController pushViewController:addAddr animated:YES];
}

- (void)requestData:(BOOL)isLoadMore{
    [MeServer getAddressListSuccess:^(AddressListModel *result) {
        self.dataArray = result.address_list;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)setIsSelAddr:(BOOL)isSelAddr{
    _isSelAddr = isSelAddr;
    if (_isSelAddr) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma UITableViewDelegate
static NSString *AddressCellId = @"AddressCellId";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressCellId];
    if (cell == nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressCellId];
    }
    cell.delegate = self;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel *adrModel = self.dataArray[indexPath.row];
    
    if (_isSelAddr) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kSelectAddress object:adrModel];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MeServer getEditAddressWithExtmId:adrModel.extm_id extmName:adrModel.extm_name sex:adrModel.sex address:adrModel.address zipCode:adrModel.zip_code extm_phone:adrModel.extm_phone Success:^(AddressModel *result) {
            [self requestData:NO];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
            
        }];
    }
    
}

- (void)editButtonClick:(AddressModel *)model{
    AddAddressViewController *addAddr = [[AddAddressViewController alloc] init];
    addAddr.navTitle = NSLocalizedString(kEditAddress, nil);
    addAddr.model = model;
    [self.navigationController pushViewController:addAddr animated:YES];
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
