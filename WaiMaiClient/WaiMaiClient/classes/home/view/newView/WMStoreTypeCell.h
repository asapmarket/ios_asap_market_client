//
//  WMStoreTypeCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTypeModel.h"

@interface WMStoreTypeCell : UITableViewCellExt

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger index;

+ (CGFloat)cellHeightWithArray:(NSMutableArray *)array;

@property (nonatomic, copy) void (^sessionViewDidTouchBlock)(StoreTypeModel *partyItem , NSInteger row);

@property (nonatomic, copy) void (^listButtonDidTouchBlock)(UIButton *button);


@end
