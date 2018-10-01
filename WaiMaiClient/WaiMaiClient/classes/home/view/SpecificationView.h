//
//  SpecificationView.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodsTypeModel.h"

@class SpecificationView;

@protocol SpecificationViewDelegate <NSObject>

- (void)confirmBtnClickWithListModel:(FoodsListModel *)listModel;

@end

@interface SpecificationView : UIView

@property (nonatomic, weak)id <SpecificationViewDelegate> delegate;
@property (nonatomic, strong) FoodsListModel *listModel;

@end
