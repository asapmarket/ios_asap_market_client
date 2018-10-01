//
//  IndentViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "IndentViewController.h"
#import "OrderBaseModel.h"
#import "OrderVierCell.h"
#import "OederDetailViewController.h"
#import "OrderServer.h"
#import "OrderSegmentView.h"
#import "RunOrderParam.h"
#import "RunOrderCell.h"
#import "RunOrderDetailVC.h"

@interface IndentViewController ()<OrderVierCellDelegate, UITableViewDelegate, UITableViewDataSource, RunOrderCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) OrderSegmentView *segmentView;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int runPage;
@property (nonatomic, assign) BOOL isToLogin;

@property (nonatomic, strong) RunOrderParam *param;
@property (nonatomic, strong) NSMutableArray *runDataArray;

@property (nonatomic, assign) NSInteger type; // 0:外卖订单  1：跑腿订单

@property (nonatomic, assign) CGFloat tableViewH;

@end

@implementation IndentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _param = [[RunOrderParam alloc] init];
    _page = 1;
    _runPage = 1;
    [self isLogin];
    [self initData];
    if (self.cartView) {
        [self.cartView setCount:[SCUtil getGoodsCount]];
    }
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
    self.view.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
    if (_navTitle) {
        [self setTopBarTitle:_navTitle];
        _tableViewH = SCREEN_HEIGHT-44- TopBarHeight;
        
    }else{
        [self setTopBarTitle:NSLocalizedString(kOrder, nil)];

        _tableViewH = SCREEN_HEIGHT-44- ButomBarHeight - TopBarHeight;
    }
    
    _type = 0;
    __weak typeof(self) weakSelf = self;
    _segmentView = [[OrderSegmentView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, 44)];
    _segmentView.oderButtonBlock = ^(UIButton *button) {
       
        if (weakSelf.type == 0) {
            [weakSelf.tableView reloadData];
            return ;
        }else{
            weakSelf.type = 0;
            if (weakSelf.dataArray.count > 0) {
                [weakSelf.tableView reloadData];
            }else{
                [weakSelf initData];
            }
        }
    };
    
    _segmentView.runButtonBlock = ^(UIButton *button) {
        if (weakSelf.type == 1) {
            [weakSelf.tableView reloadData];
            return ;
        }else{
            weakSelf.type = 1;
            if (weakSelf.runDataArray.count > 0) {
                [weakSelf.tableView reloadData];
            }else{
                [weakSelf initData];
            }
        }
    };
    [self.view addSubview:_segmentView];
    [self initTableView];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+TopBarHeight, SCREEN_WIDTH, _tableViewH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)headerRefreshing{
    _page = 1;
    [self initData];
}

- (void)footerRefreshing{
    _page ++;
    [self initData];
}

- (void)initData{
    NSString *state;
    
    if (_navTitle) {
        state = @"4"; //已完成订单
        _param.state = state;
    }else{
        state = @"6"; //未完成订单
        _param.state = state;
    }
    _param = [[RunOrderParam alloc] init];
    _param.page = [NSString stringWithFormat:@"%d",_page];
    _param.page_size = @"10";
    _param.user_id = [UrlsManager userID];
    _param.token = [UrlsManager token];
    
    
    if (_type == 0) {
        [OrderServer getOrderListUrlWithPage:_page state:state Success:^(OrderBaseModel *result) {
            if (_page == 1) {
                _dataArray = result.rows;
                [self.tableView.mj_header endRefreshing];
            }else{
                [_dataArray addObjectsFromArray:result.rows];
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView reloadData];
            if (_navTitle) {
                [self shopCartView];
            }
            
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }else{
        [OrderServer postRunOrderListWithParam:_param success:^(RunOrderModel *result) {
            if (_page == 1) {
                _runDataArray = result.rows;
                [self.tableView.mj_header endRefreshing];
            }else{
                [_runDataArray addObjectsFromArray:result.rows];
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView reloadData];
            if (_navTitle) {
                [self shopCartView];
            }
            
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type == 0) {
        return _dataArray.count;
    }else{
        return _runDataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        OrderListModel *model = _dataArray[indexPath.section];
        return [OrderVierCell cellHeightWithModel:model];
    }else{
        RunOrderItem *item = _runDataArray[indexPath.row];
        return [RunOrderCell cellHeightWithModel:item];
    }
    
}

static NSString *OrderCellId = @"OrderCellId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == 0) {
        OrderListModel *model = _dataArray[indexPath.row];
        OrderVierCell *orderCell = [tableView cellForRowAtIndexPath:indexPath];
        if (orderCell == nil) {
            orderCell = [[OrderVierCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderCellId];
        }
        
        orderCell.delegate = self;
        orderCell.model = model;
        return orderCell;
    }else{
        RunOrderItem *item = _runDataArray[indexPath.row];
        RunOrderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[RunOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RunOrderID"];
        }
        cell.delegate = self;
        cell.item = item;
        return cell;
    }
   
}


- (void)detailButtonClickWithModel:(OrderListModel *)model{
    NSLog(@"detailButtonClick:%@",model.order_id);
    OederDetailViewController *orderDetail  = [[OederDetailViewController alloc] init];
    orderDetail.orderId = model.order_id;
    orderDetail.isPay = NO;
    [self.navigationController pushViewController:orderDetail animated:YES];
}

- (void)runOrderDetailButtonClickWithModel:(RunOrderItem *)model{
    RunOrderDetailVC *detailVc = [[RunOrderDetailVC alloc] init];
    detailVc.order_id = model.order_id;
    [self.navigationController pushViewController:detailVc animated:YES];
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
