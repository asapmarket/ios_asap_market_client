//
//  FoodDetailViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "ShopCartViewController.h"
#import "UINavigationBar+Awesome.h"
#import "FoodsDetailBaseModel.h"
#import "FoodDetailHeaderCell.h"
#import "FoodDetailFooterCell.h"
#import "FoodAddCell.h"
#import "SpecificationView.h"
#import "HomeServer.h"

#define NAVBAR_CHANGE_POINT 210

@interface FoodDetailViewController ()<UITableViewDelegate, UITableViewDataSource, FoodAddCellDelegate, SpecificationViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FoodsDetailBaseModel *baseModel;
@property (nonatomic, strong) ShopCartModel *shopModel;
@property (nonatomic, assign) int goodsCount;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, assign) CGFloat alpha;


@end

@implementation FoodDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.topBarView.hidden = YES;
    if (_isDefault) {
        UIColor * color = ThemeColor;
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:_alpha]];
        self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"back_white" highIcon:@"back_white" target:self action:@selector(back)];
    }
    [self initData];
    _goodsCount = [SCUtil getGoodsCount];
    if (self.cartView) {
        [self.cartView setCount:_goodsCount];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar lt_reset];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_back" highIcon:@"icon_back" target:self action:@selector(back)];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor * color = ThemeColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 50) {
        _alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT+50 - offsetY) / NAVBAR_CHANGE_POINT));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:_alpha]];
    } else {
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    if (offsetY > 150) {
        _isDefault = NO;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_back" highIcon:@"icon_back" target:self action:@selector(back)];
        self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    }else{
        _isDefault = YES;
        self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"back_white" highIcon:@"back_white" target:self action:@selector(back)];
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isDefault = YES;
    _alpha = 0;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
 
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"back_white" highIcon:@"back_white" target:self action:@selector(back)];
    self.navigationItem.title = NSLocalizedString(kFoodDetail, nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTableView];
    [self initData];
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)initData{
    
    [HomeServer getFoodsDetailUrlWithStoreId:_foodModel.store_id foodsId:_foodModel.foods_id Success:^(FoodsDetailBaseModel *result) {
        NSLog(@"%@",result.mj_keyValues);
        _baseModel = result;
        _baseModel.storeInfo = _storeDetail;
        _baseModel = [SCUtil updataFoodsDetailBaseModel:_baseModel];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self shopCartView];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _baseModel.foods_detail.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 265;
    }else if (indexPath.row == 1){
        return 65;
    }else{
        return 240;
    }
}

static NSString *HeadCellID = @"HeadCellID";
static NSString *MiddleCellID = @"MiddleCellID";
static NSString *FooterCellID = @"FooterCellID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FoodDetailHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:HeadCellID];
        if (headerCell == nil) {
            headerCell = [[FoodDetailHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeadCellID];
        }
        [headerCell setBaseModel:_baseModel];
        return headerCell;
    }else if (indexPath.row == 1){
        
        FoodAddCell *addCell = [tableView dequeueReusableCellWithIdentifier:MiddleCellID];
        if (addCell == nil) {
            addCell = [[FoodAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MiddleCellID];
        }
        [addCell setFoodsModel:_baseModel];
        addCell.delegate = self;
        
        return addCell;
        
    }else{
        FoodDetailFooterCell *footCell = [tableView dequeueReusableCellWithIdentifier:FooterCellID];
        if (footCell == nil) {
            footCell = [[FoodDetailFooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FooterCellID];
        }
        [footCell setModel:_baseModel.foods_detail[indexPath.row-2]];
        return footCell;
    }
}

#pragma foodAddCellDelegate
- (void)onAddButtonClick:(FoodsDetailBaseModel *)model{
    if ([model.has_spec isEqualToString:@"1"] && model.spec_class_list.count > 0) {
        SpecificationView *specView = [[SpecificationView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [specView setListModel:[SCUtil getFoodListModel:model]];
        specView.delegate = self;
        [self.view addSubview:specView];
        [self.view bringSubviewToFront:specView];
    }else{
        _shopModel = [SCUtil getShopCartModel:model.storeInfo foodDetail:[SCUtil getFoodListModel:model]];
        [[ShopCartManager shareManager] addObjectWithShopCartModel:_shopModel];
        _goodsCount = [SCUtil getGoodsCount];
        [self.cartView setCount:_goodsCount];
    }
}

- (void)onMinusButonClicl:(FoodsDetailBaseModel *)model{
    if ((([model.has_spec isEqualToString:@"0"] || model.has_spec == nil) && model.count > 0) || model.count == 0 || model.spec_class_list.count == 0) {
        _shopModel = [SCUtil getShopCartModel:_baseModel.storeInfo foodDetail:[SCUtil getFoodListModel:model]];
        [[ShopCartManager shareManager] removeObjectWithShopCartModel:_shopModel];
        _goodsCount = [SCUtil getGoodsCount];
        [self.cartView setCount:_goodsCount];
    }else{
        [self onTapShopCartView];
        NSLog(@"多规格商品请进入购物车删除");
    }
}

#pragma SpecificationViewDelegate
- (void)confirmBtnClickWithListModel:(FoodsListModel *)listModel{
    _shopModel.specAllId = listModel.specAllID;
    _baseModel.count = listModel.count;
    _shopModel = [SCUtil getShopCartModel:_baseModel.storeInfo foodDetail:listModel];
    [[ShopCartManager shareManager] addObjectWithShopCartModel:_shopModel];
    _shopModel.specAllId = nil;
    _shopModel.specName_cn = nil;
    _shopModel.specName_en = nil;
    _goodsCount = [SCUtil getGoodsCount];
    [self.cartView setCount:_goodsCount];
    [self.tableView reloadData];
    
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
