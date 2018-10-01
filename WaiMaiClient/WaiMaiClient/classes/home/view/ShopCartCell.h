//
//  ShopCartCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodsListModel.h"
#import "MyShopCartSection.h"

@class ShopCartCell;

@protocol ShopCartCellDelegate <NSObject>

- (void)shopCartCellTap:(MyShopCartSection *)sectionModel;

@end

@interface ShopCartCell : UITableViewCell

@property (nonatomic, weak)id<ShopCartCellDelegate>delegate;

@property (nonatomic, strong) FoodsListModel *listModel;
@property (nonatomic, strong) MyShopCartSection *section;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
