//
//  WMBannerCell.h
//  WaiMaiClient
//
//  Created by 王 on 2018/8/17.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHomeBannerView.h"

@interface WMBannerCell : UITableViewCell

@property (nonatomic, strong) CYHomeBannerView *bannerView;
@property (nonatomic, strong) NSMutableArray *bannerArray;

@end
