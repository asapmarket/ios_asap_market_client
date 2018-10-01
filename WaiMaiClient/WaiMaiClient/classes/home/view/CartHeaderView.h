//
//  CartHeaderView.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyShopCartSection.h"

@class CartHeaderView;

@protocol CartHeaderViewDelegate <NSObject>

- (void)leftSelectButtonClick:(MyShopCartSection *)sectionModel;

- (void)headerViewDidTap:(MyShopCartSection *)sectionModel;

@end

@interface CartHeaderView : UIView

@property (nonatomic, weak)id <CartHeaderViewDelegate>delegate;

@property (nonatomic, strong) MyShopCartSection *section;
@property (nonatomic, assign) BOOL isSubmit ;

@end
