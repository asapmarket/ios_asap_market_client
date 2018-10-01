//
//  StoreViewCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreListModel.h"

@class StoreViewCell;

@protocol StoreViewCellDelegate <NSObject>

- (void)storeViewDidClick:(StoreModel *)model;

@end

@interface StoreViewCell : UITableViewCell

@property (nonatomic, weak)id<StoreViewCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *storeArray;;

@end
