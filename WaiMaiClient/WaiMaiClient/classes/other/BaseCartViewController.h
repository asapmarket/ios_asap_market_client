//
//  BaseCartViewController.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UIViewControllerExt.h"
#import "ShopCartManager.h"
#import "ShopCartViewController.h"
#import "SCUtil.h"
#import "ShopCartView.h"

@interface BaseCartViewController : UIViewControllerExt

@property (nonatomic, strong) ShopCartView *cartView;

- (void)shopCartView;

- (void)onTapShopCartView;
@end
