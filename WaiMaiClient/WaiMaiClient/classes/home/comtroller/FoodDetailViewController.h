//
//  FoodDetailViewController.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/3.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BaseCartViewController.h"
#import "FoodsListModel.h"
#import "StoreDetailModel.h"

@interface FoodDetailViewController : BaseCartViewController

@property (nonatomic, strong) FoodsListModel *foodModel;
@property (nonatomic, strong) StoreDetailModel *storeDetail;

@end
