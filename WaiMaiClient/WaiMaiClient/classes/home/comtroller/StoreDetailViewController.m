//
//  StoreDetailViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "StoreDetailHeaderView.h"
#import "StoreDetailModel.h"
#import "StoreGoodsBaseModel.h"
#import "LeftGoodsCell.h"
#import "RightGoodsCell.h"
#import "SpecificationView.h"
#import "FoodDetailViewController.h"
#import "ShopCartViewController.h"
#import "HomeServer.h"
#import <QuartzCore/CALayer.h>

@interface StoreDetailViewController ()<UITableViewDelegate, UITableViewDataSource, RightGoodsCellDelegate, SpecificationViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray  *dateArray;
@property (nonatomic, strong) StoreDetailHeaderView *headerView;
@property (nonatomic, strong) StoreDetailModel *detailModel;
@property (nonatomic, strong) StoreGoodsBaseModel *baseModel;
@property (nonatomic, strong) ShopCartModel *shopModel;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, assign) int goodsCount;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isScrollDown;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;


@end

@implementation StoreDetailViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_dateArray.count > 0) {
        _baseModel.type_list = [SCUtil updateStoreDataWithStoreDetail:_detailModel storeBaseModel:_baseModel];
        _dateArray = _baseModel.type_list;
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    }
    _goodsCount = [SCUtil getGoodsCount];
    if (self.cartView) {
        [self.cartView setCount:_goodsCount];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kStoreDetail, nil)];
    _selectIndex = 0;
    _isScrollDown = YES;

    [self initView];
    [self initData];

}

- (void)initData{
    _baseModel = [[StoreGoodsBaseModel alloc] init];
    _shopModel = [[ShopCartModel alloc] init];

    _dateArray = [NSMutableArray array];
    
    [HomeServer getStoreDetailWithStoreId:_storeId Success:^(StoreDetailModel *result) {
        _detailModel = result;
        [self initHeaderView];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    

    [HomeServer getStoreFoodListWithStoreId:_storeId Success:^(StoreGoodsBaseModel *result) {
        _baseModel = result;
        _baseModel.type_list = [SCUtil updateStoreDataWithStoreDetail:_detailModel storeBaseModel:_baseModel];
        for (FoodsTypeModel *type in _baseModel.type_list) {
            if (type.foods_list.count > 0) {
                [_dateArray addObject:type];
            }
        }
        _goodsCount = [SCUtil getGoodsCount];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionNone];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)initHeaderView{
    if (!_headerView){
        _headerView = [[StoreDetailHeaderView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, 107)];
        [self.view addSubview:_headerView];
    }
    [_headerView setDetailModel:_detailModel];
}


- (void)initView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 107+TopBarHeight, SCREEN_WIDTH, 45)];
    titleView.backgroundColor = [UIColor hexStringToColor:@"#cce8ff"];
    [self.view addSubview:titleView];
    UILabel *titleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#323232"] textAlignment:NSTextAlignmentLeft];
    titleLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 45);
    titleLabel.text = NSLocalizedString(kFoodList, nil);
    [titleView addSubview:titleLabel];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    
    
    [self shopCartView];
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 152+TopBarHeight, 80, SCREEN_HEIGHT-131-TopBarHeight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 53;
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
//        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];

    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 152+TopBarHeight, SCREEN_WIDTH-80, SCREEN_HEIGHT-131-TopBarHeight)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 103;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
    }
    return _rightTableView;
}

#pragma UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else
    {
        return self.dateArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return self.dateArray.count;
    }
    else
    {
        FoodsTypeModel *model =self.dateArray[section];
        return model.foods_list.count;
    }
}

static NSString *LeftCellID = @"LeftCellID";
static NSString *RightCellID = @"RightCellID";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
       
        FoodsTypeModel *model = _dateArray[indexPath.row];
        LeftGoodsCell *leftCell = [tableView dequeueReusableCellWithIdentifier:LeftCellID];
        if (leftCell == nil) {
            leftCell = [[LeftGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LeftCellID];
        }
        if ([LanguageManager shareManager].language == 0) {
            leftCell.name.text = model.type_name_en;
        }else{
            leftCell.name.text = model.type_name_cn;
        }
        return leftCell;
        
    }
    else
    {
        FoodsTypeModel *typeModel;
        if (_dateArray.count > indexPath.section) {
            typeModel =  _dateArray[indexPath.section];
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
            return cell;
        }
        if (typeModel.foods_list.count == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
            return cell;
        }else{
            FoodsListModel *listModel = typeModel.foods_list[indexPath.row];
            RightGoodsCell *rightCell = [tableView dequeueReusableCellWithIdentifier:RightCellID];
            if (rightCell == nil) {
                rightCell = [[RightGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RightCellID];
            }
            rightCell.delegate = self;
            [rightCell setFoodsModel:listModel];
            [rightCell setTypeModel:typeModel];
            
            return rightCell;
        }
      
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 0.1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        view.backgroundColor = [UIColor whiteColor];

        return view;
    }
    return nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }else{
        FoodsTypeModel *typeModel;
        if (_dateArray.count > indexPath.section) {
            typeModel =  _dateArray[indexPath.section];
            FoodsListModel *listModel = typeModel.foods_list[indexPath.row];
            
            FoodDetailViewController *detailCtrl = [[FoodDetailViewController alloc] init];
            detailCtrl.foodModel = listModel;
            detailCtrl.storeDetail = _detailModel;
            [self.navigationController pushViewController:detailCtrl animated:YES];
        }
    }
}

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self.rightTableView rectForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _rightTableView.contentInset.top);
    [self.rightTableView setContentOffset:topOfHeader animated:animated];
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    if (index >= _dateArray.count) {
        return;
    }
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

#pragma rightCellDelegate
- (void)onAddButtonClick:(FoodsListModel *)model typeModel:(FoodsTypeModel *)typeModel rightCell:(RightGoodsCell *)rightCell{
    if ([model.has_spec isEqualToString:@"1"] && model.spec_class_list.count > 0) {
        SpecificationView *specView = [[SpecificationView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-TopBarHeight)];
        [specView setListModel:model];
        specView.delegate = self;
        [self.view addSubview:specView];
        [self.view bringSubviewToFront:specView];
    }else{
        _shopModel = [SCUtil getShopCartModel:_detailModel foodDetail:model];
        [[ShopCartManager shareManager] addObjectWithShopCartModel:_shopModel];
        _goodsCount = [SCUtil getGoodsCount];
        [self.cartView setCount:_goodsCount];
    }
}

- (void)onMinusButonClicl:(FoodsListModel *)model typeModel:(FoodsTypeModel *)typeModel rightCell:(RightGoodsCell *)rightCell{
    if ((([model.has_spec isEqualToString:@"0"] || model.has_spec == nil) && model.count > 0) || model.count == 0 || model.spec_class_list.count == 0) {
        _shopModel = [SCUtil getShopCartModel:_detailModel foodDetail:model];
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
    _shopModel = [SCUtil getShopCartModel:_detailModel foodDetail:listModel];
    [[ShopCartManager shareManager] addObjectWithShopCartModel:_shopModel];
    _shopModel.specAllId = nil;
    _shopModel.specName_cn = nil;
    _shopModel.specName_en = nil;
    _goodsCount = [SCUtil getGoodsCount];
    [self.cartView setCount:_goodsCount];
    [self.rightTableView reloadData];
    
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
