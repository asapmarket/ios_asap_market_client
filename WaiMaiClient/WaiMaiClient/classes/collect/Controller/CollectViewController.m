//
//  CollectViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectServer.h"
#import "ShopCollectionViewCell.h"
#import "StoreDetailViewController.h"
#import "HomeServer.h"

@interface CollectViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;

@end

@implementation CollectViewController

//- (void)setModel:(StoreTypeModel *)model{
//    _model = model;
//    if ([LanguageManager shareManager].language == 0){
//        self.navigationItem.title  = model.type_name_en;
//    }else{
//        self.navigationItem.title  = model.type_name_cn;
//    }
//
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self initData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if (_model == nil) {
//        self.navigationItem.title = NSLocalizedString(kCollect, nil);
//    }
//    self.view.backgroundColor = ThemeBgColor;
//    _page = 1;
//
//    [self initView];
//    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefreshing)];
//    [self.collectionView addFooterWithTarget:self action:@selector(footerRefreshing)];
}

//- (void)headerRefreshing{
//    [self.collectionView headerEndRefreshing];
//    _page = 1;
//    [self initData];
//}
//
//- (void)footerRefreshing{
//    [self.collectionView footerEndRefreshing];
//    _page ++;
//    [self initData];
//}
//
//- (void)initData{
//
//    if (_model) {
//        [HomeServer getStoreListWithPage:_page type:_model.type_id Success:^(StoreListModel *result) {
//            [self initViewWithData:result];
//        } failure:^(NSError *error) {
//            [self errorResponsText:error];
//        }];
//    }else{
//        [CollectServer getCollectListWithPage:_page Success:^(StoreListModel *result) {
//            [self initViewWithData:result];
//        } failure:^(NSError *error) {
//            [self errorResponsText:error];
//        }];
//    }
//}
//
//- (void)initViewWithData:(StoreListModel *)model{
//    if (_page == 1) {
//        _dataArray = model.rows;
//    }else{
//        [_dataArray addObjectsFromArray:model.rows];
//    }
//    [self.collectionView reloadData];
//    [self shopCartView];
//}
//
//- (void)initView{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.minimumInteritemSpacing = 10;
//    layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2.0, 220);
//
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.showsHorizontalScrollIndicator = NO;
//    _collectionView.showsVerticalScrollIndicator = NO;
//    [_collectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
//
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_collectionView];
//
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
//    cell.layer.borderColor = [UIColor hexStringToColor:@"#ebebeb"].CGColor;
//    cell.layer.borderWidth = 0.5;
//    cell.model = _dataArray[indexPath.row];
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    StoreModel *model = _dataArray[indexPath.row];
//    StoreDetailViewController *detailCtrl = [[StoreDetailViewController alloc] init];
//    detailCtrl.storeId = model.store_id;
//    [self.navigationController pushViewController:detailCtrl animated:YES];
//
//}

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
