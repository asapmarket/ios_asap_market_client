//
//  OederDetailViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OederDetailViewController.h"
#import "OrderDetailBaseModel.h"
#import "OrderStoreListCell.h"
#import "OrderDetailHeaderCell.h"
#import "CourierLocationCell.h"
#import "OrderServer.h"
#import "WTabBarController.h"
#import "OrderPriceCell.h"

@interface OederDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) OrderDetailBaseModel *baseModel;

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UILabel *label;

@end

@implementation OederDetailViewController

- (void)leftButtonAction{
    if (_isPay) {
        WTabBarController *tabBar = [[WTabBarController alloc] init];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        [tabBar WTabBarViewControllerToOrder];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//    [_view1 removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_isPay) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_isPay) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kIndentDetail, nil);
    [self setTopBarTitle:NSLocalizedString(kIndentDetail, nil)];
    [self initData];
    [self initView];
    self.navigationController.delegate = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReference)];
}

- (void)headerReference{
    [self.tableView.mj_header endRefreshing];
    [self initData];
}

- (void)initData{
   
    [OrderServer getOrderDetailUrlWithOrderId:_orderId Success:^(OrderDetailBaseModel *result) {
        NSLog(@"%@",result.mj_keyValues);
        _baseModel = result;
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
    return _baseModel.store_list.count+3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 155;
    }else if(indexPath.row == _baseModel.store_list.count+2){
        return 285;
    }else if(indexPath.row == _baseModel.store_list.count+1){
        return 80;
    }else{
        OrderDetailStoreModel *storeModel = _baseModel.store_list[indexPath.row-1];
        return [OrderStoreListCell cellHeightWithModel:storeModel];
    }
}

static NSString *HeadCellID = @"HeadCellID";
static NSString *StoreCellID = @"StoreCellID";
static NSString *FooterCellID = @"FooterCellID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        OrderDetailHeaderCell *headerCell = [tableView cellForRowAtIndexPath:indexPath];
        if (headerCell == nil){
            headerCell = [[OrderDetailHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeadCellID];
        }
        [headerCell setBaseModel:_baseModel];
        
        return headerCell;
    }else if(indexPath.row == _baseModel.store_list.count+1){
        
        OrderPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:@"PriceCellId"];
        if (priceCell == nil) {
            priceCell = [[OrderPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PriceCellId"];
        }
        [priceCell setBaseModel:_baseModel];
        return priceCell;
        
    }else if(indexPath.row == _baseModel.store_list.count+2){
        
        CourierLocationCell *locationCell = [tableView dequeueReusableCellWithIdentifier:FooterCellID];
        if (locationCell == nil) {
            locationCell = [[CourierLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FooterCellID];
        }
        [locationCell setBaseModel:_baseModel];
        return locationCell;
        
    }else{
        OrderDetailStoreModel *storeModel = _baseModel.store_list[indexPath.row-1];
        OrderStoreListCell *storeCell = [tableView cellForRowAtIndexPath:indexPath];
        if (storeCell == nil) {
            storeCell = [[OrderStoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StoreCellID];
        }
        [storeCell setStoreModel:storeModel];
        
        return storeCell;
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
