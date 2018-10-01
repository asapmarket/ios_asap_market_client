//
//  ShopCartViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopCartViewController.h"
#import "MyShopCartBaseModel.h"
#import "CartHeaderView.h"
#import "ShopCartCell.h"
#import "StoreDetailViewController.h"
#import "CalculatePrice.h"
#import "StringColor.h"
#import "SubmitOrderViewController.h"
#import "SCUtil.h"
#import "HomeServer.h"
#import "OrderParam.h"

@interface ShopCartViewController ()<UITableViewDelegate, UITableViewDataSource, CartHeaderViewDelegate, ShopCartCellDelegate>

@property (nonatomic, strong) MyShopCartBaseModel *baseModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *settlementView;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ShopCartViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kShopCart, nil) rightText:NSLocalizedString(kClearShopCart, nil)];
    [self.rightButton setTitleColor:[UIColor hexStringToColor:@"40AFFF"] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont font13];
    [self initTableView];
    [self initView];
}

- (void)rightButtonAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kConfirmExitShopCart,nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [[ShopCartManager shareManager] clearShopCart];
        [_baseModel.dataArray removeAllObjects];
        [self.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:verifyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)initData{
    _cartBaseModel = [[ShopCartManager shareManager] loadShopCartBaseModel];
    _baseModel = [[MyShopCartBaseModel alloc] init];

    _baseModel.dataArray = [MyShopCartBaseModel getMyShopCartBaseModel:_cartBaseModel];
    
    _priceLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@$%.2f",NSLocalizedString(kTotal, nil),[CalculatePrice getPriceWithDataArray:_baseModel.dataArray]] index:NSLocalizedString(kTotal, nil).length textColor:ButtonColor];
    
    [self.tableView reloadData];

}


- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-TopBarHeight-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeBgColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)initView{
    _settlementView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    _settlementView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_settlementView];
    [self.view bringSubviewToFront:_settlementView];
    
    _priceLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#808080"] textAlignment:NSTextAlignmentRight];
    _priceLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-129, 49);
    [_settlementView addSubview:_priceLabel];
    
    UIButton *totalButton = [CreateButton initWithFrame:CGRectMake(SCREEN_WIDTH-109, 7.5, 99, 34) title:NSLocalizedString(kSettlement, nil) titleColor:[UIColor whiteColor] target:self action:@selector(totalButtonClick)];
    [totalButton setBackgroundColor:ButtonColor];
    [_settlementView addSubview:totalButton];
}

- (void)totalButtonClick{
    MyShopCartBaseModel *model = [CalculatePrice updateMyShopCartBaseModel:_baseModel];
    if (model.dataArray.count > 0) {
        OrderUpBaseModel *upParam = [OrderParam getOrderParamWithCartBaseModel:model patType:nil remark:nil ectmId:nil distribution_time:nil];

        [HomeServer getOrderTotalMoneyWithParam:upParam Success:^(AmoutModel *result) {
        
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
                
                [alert addAction:verifyAction];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                SubmitOrderViewController *subCtrl = [[SubmitOrderViewController alloc] init];
                subCtrl.baseModel = model;
                [self.navigationController pushViewController:subCtrl animated:YES];
            }
            
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kShoppingCartIsEmpty,nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:verifyAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MyShopCartSection *sectionModel = _baseModel.dataArray[section];
    
    return sectionModel.food_list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _baseModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 74;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger section = indexPath.section;
    NSInteger r = indexPath.row;
    MyShopCartSection *sectionModel = _baseModel.dataArray[section];
    FoodsListModel *listModel = sectionModel.food_list[r];
    ShopCartCell *cell = [ShopCartCell cellWithTableView:tableView];
    [cell setListModel:listModel];
    [cell setSection:sectionModel];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 59;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyShopCartSection *sectionModel = _baseModel.dataArray[section];
    CartHeaderView *view = [[CartHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
    view.isSubmit = NO;
    view.delegate = self;
    [view setSection:sectionModel];
    return view;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    // 从数据源中删除
    NSUInteger section = indexPath.section;
    NSInteger r = indexPath.row;
    MyShopCartSection *sectionModel = _baseModel.dataArray[section];
    FoodsListModel *listModel = sectionModel.food_list[r];
    ShopCartModel *cartModel = [SCUtil getShopCartModel:sectionModel.detailModel foodDetail:listModel];
    if (cartModel.specAllId) {
        cartModel.specCount = 0;
    }else{
        cartModel.count = 0;
    }
    [[ShopCartManager shareManager] removeObjectWithShopCartModel:cartModel];

    [sectionModel.food_list removeObjectAtIndex:r];
    
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [tableView endUpdates];
    if (sectionModel.food_list.count == 0) {
        [_baseModel.dataArray removeObjectAtIndex:section];
        [tableView reloadData];
    }
    _priceLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@$%.2f",NSLocalizedString(kTotal, nil),[CalculatePrice getPriceWithDataArray:_baseModel.dataArray]] index:NSLocalizedString(kTotal, nil).length textColor:ButtonColor];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(kDelete, nil);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma HeaderDelegate
- (void)leftSelectButtonClick:(MyShopCartSection *)sectionModel{
    for (FoodsListModel *listModel in sectionModel.food_list) {
        listModel.isSelect = sectionModel.isSelect;
    }
    _priceLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@$%.2f",NSLocalizedString(kTotal, nil),[CalculatePrice getPriceWithDataArray:_baseModel.dataArray]] index:NSLocalizedString(kTotal, nil).length textColor:ButtonColor];
    [self.tableView reloadData];
}

- (void)headerViewDidTap:(MyShopCartSection *)sectionModel{
//    StoreDetailViewController *storeDetailCtrl = [[StoreDetailViewController alloc] init];
//    storeDetailCtrl.storeId = sectionModel.detailModel.store_id;
//    [self.navigationController pushViewController:storeDetailCtrl animated:YES];
}

#pragma ShopCartCellDelegate
- (void)shopCartCellTap:(MyShopCartSection *)sectionModel{
    if ([self isSelect:sectionModel] == 1) {
        sectionModel.isSelect = YES;
        [self.tableView reloadData];
    }else if([self isSelect:sectionModel] == 2){
        sectionModel.isSelect = NO;
        [self.tableView reloadData];
    }else{
        sectionModel.isSelect = NO;
        [self.tableView reloadData];
    }
    _priceLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@$%.2f",NSLocalizedString(kTotal, nil),[CalculatePrice getPriceWithDataArray:_baseModel.dataArray]] index:NSLocalizedString(kTotal, nil).length textColor:ButtonColor];
    
}

//1 表示全部选中 2表示全部未选中
- (NSInteger)isSelect:(MyShopCartSection *)sectionModel{
    int selectCount = 0;
    int unSelectCount = 0;
    for (int i=0; i<sectionModel.food_list.count; i++) {
        FoodsListModel *listModel = sectionModel.food_list[i];
        if (listModel.isSelect) {
            selectCount ++;
        }else{
            unSelectCount ++;
        }
    }
    if (selectCount == sectionModel.food_list.count) {
        return 1;
    }else if (unSelectCount == sectionModel.food_list.count){
        return 2;
    }else{
        return 3;
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
