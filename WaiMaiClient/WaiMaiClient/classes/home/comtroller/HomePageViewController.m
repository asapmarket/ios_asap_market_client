//
//  HomePageViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomePageViewController.h"
#import "StoreViewCell.h"
#import "HomeMainModel.h"
#import "StoreListModel.h"
#import "HotFoodsView.h"
#import "FoodDetailViewController.h"
#import "SetPersonalViewController.h"
#import "HomeServer.h"
#import "RunView.h"
#import "RunViewController.h"
#import "WMBannerCell.h"
#import "WMStoreTypeCell.h"
#import "WMStoreListCell.h"

#import "WMRunView.h"

@interface HomePageViewController ()

@property (nonatomic, strong) NSMutableArray *homepageBanner;
@property (nonatomic, strong) NSMutableArray *storeArray;
@property (nonatomic, strong) ImageModel *bannerModel;
@property (nonatomic, strong) HomeMainModel *baseModel;

@property (nonatomic, strong) StoreTypeModel *typeItem;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isPickUp;

@property (nonatomic, strong) WMRunView *wmRunView;

@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[ShopCartManager shareManager] setShopCartCount:[SCUtil getGoodsCount]];;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setTopBarTitle:NSLocalizedString(@"home", nil) rightText:@"ENG"];
    self.topBottomLine.hidden=YES;
    self.topBarView.hidden = YES;
    _index = 0;
    
    _isPickUp = NO;

    self.topBarView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    self.topTitleLabel.textColor = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([LanguageManager shareManager].language == 0){
        [self.rightButton setTitle:@"中文" forState:UIControlStateNormal];
    }else{
        [self.rightButton setTitle:@"ENG" forState:UIControlStateNormal];
    }
    [self setUI];
}

- (void)setUI{
    if (!_wmRunView) {
        __weak typeof(self) weakSelf = self;
        _wmRunView = [[WMRunView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, TopBarHeight)];
        _wmRunView.runViewDidTouchBlock = ^(WMRunView *runView) {
            RunViewController *runVC = [[RunViewController alloc] init];
            [weakSelf.navigationController pushViewController:runVC animated:YES];
        };
        _wmRunView.hidden = YES;
        [self.view addSubview:_wmRunView];
        [self.view bringSubviewToFront:_wmRunView];
    }
}

- (void)rightButtonAction{
    if ([LanguageManager shareManager].language == 0){
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChange object:kSetChinese];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChange object:kSetEnglish];
    }
}

- (void)requestData:(BOOL)isLoadMore{
    if (!isLoadMore) {
        self.page = 1;
        _index = 0;
        [HomeServer getHomePageInfoSuccess:^(HomeMainModel *result) {
            _baseModel = result;
            self.homepageBanner = _baseModel.banner_list;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            if (_baseModel.type_list.count > 0) {
                _typeItem= _baseModel.type_list[0];
                [HomeServer getStoreListWithPage:self.page type:_typeItem.type_id Success:^(StoreListModel *result) {
                    self.storeArray = result.rows;
                    if (result.rows.count < 9) {
                        self.canLoadMore = NO;
                    }else{
                        self.canLoadMore = YES;
                    }
                    [self.tableView reloadData];
                    
                } failure:^(NSError *error) {
                    [self errorResponsText:error];
                }];
            }
        } failure:^(NSError *error) {
            
            [self errorResponsText:error];
        }];
        
        

    }else{
        self.page ++;
        [HomeServer getStoreListWithPage:self.page type:_typeItem.type_id Success:^(StoreListModel *result) {
            [self.storeArray addObjectsFromArray:result.rows];
            [self.tableView.mj_footer endRefreshing];
            if (result.rows.count < 9) {
                self.canLoadMore = NO;
            }else{
                self.canLoadMore = YES;
            }
            [self.tableView reloadData];

        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
}

- (void)loadData{
    self.page = 1;
    [MBProgressHUD showMessage:nil];
    [HomeServer getStoreListWithPage:self.page type:_typeItem.type_id Success:^(StoreListModel *result) {
        self.storeArray = result.rows;
        [MBProgressHUD hideHUD];
        if (result.rows.count < 9) {
            self.canLoadMore = NO;
        }else{
            self.canLoadMore = YES;
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > AutoFit(210)) {
//        self.topBarView.hidden = YES;
        self.wmRunView.hidden = NO;
    }else {
//        self.topBarView.hidden = NO;
        self.wmRunView.hidden = YES;

    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return AutoFit(210);
    }else if (indexPath.row == 1){
        return AutoFit(60);
    }else if (indexPath.row == 2){
        if (_isPickUp) {
            return [WMStoreTypeCell cellHeightWithArray:_baseModel.type_list];
        }else{
            return 75;
        }
    }else{
        return [WMStoreListCell cellHeightWithDataArray:self.storeArray];
    }
    
}

static NSString *BannerCellID = @"BannerCellID";
static NSString *RunViewID = @"RunViewID";
static NSString *WMStoreTypeCellID = @"WMStoreTypeCellID";
static NSString *WMStoreListCellID = @"WMStoreListCellID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:{
            WMBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:BannerCellID];
            if (bannerCell == nil) {
                bannerCell = [[WMBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BannerCellID];
            }
            [bannerCell setBannerArray:self.homepageBanner];
            return bannerCell;
        }
            break;
        case 1:{
            RunView *runCell = [tableView dequeueReusableCellWithIdentifier:RunViewID];
            if (runCell == nil) {
                runCell = [[RunView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RunViewID];
            }
            runCell.runViewDidTouchBlock = ^(RunView *runView) {
                RunViewController *runVC = [[RunViewController alloc] init];
                [weakSelf.navigationController pushViewController:runVC animated:YES];
            };
            return runCell;
        }
            break;
        case 2:{
            WMStoreTypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:WMStoreTypeCellID];
            if (typeCell == nil) {
                typeCell = [[WMStoreTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WMStoreTypeCellID];
            }
            [typeCell setDataArray:_baseModel.type_list];
            typeCell.index = _index;
            typeCell.listButtonDidTouchBlock = ^(UIButton *button) {
                weakSelf.isPickUp = !button.selected;
                [weakSelf.tableView reloadData];
            };
            typeCell.sessionViewDidTouchBlock = ^(StoreTypeModel *partyItem, NSInteger row) {
                weakSelf.typeItem = partyItem;
                weakSelf.index = row;
                [weakSelf loadData];
            };
            return typeCell;
            
        }
            break;
        case 3:{
            WMStoreListCell *listCell = [tableView dequeueReusableCellWithIdentifier:WMStoreListCellID];
            if (listCell == nil) {
                listCell = [[WMStoreListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WMStoreListCellID];
            }
            [listCell setDataArray:self.storeArray];
            return listCell;
        }
            break;
        default:{
            return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];

        }
            break;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    
    
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
