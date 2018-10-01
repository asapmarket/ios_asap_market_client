//
//  WMStoreListCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMStoreListCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataArray;

+ (CGFloat)cellHeightWithDataArray:(NSMutableArray *)dataArray;

@end
