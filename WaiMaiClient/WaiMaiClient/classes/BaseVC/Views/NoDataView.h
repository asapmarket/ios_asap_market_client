//
//  NoDataView.h
//  SSKingdom
//
//  Created by chason on 2017/12/28.
//  Copyright © 2017年 3Songshu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NoDataType) {
    NoDataTypeNetwork,
    NoDataTypeData,
    NoDataTypeCustom,
    NoDataTypeProduction,
};

@interface NoDataView : UIView
@property(nonatomic,assign)NoDataType type;//无数据类型
@property (nonatomic,copy)NSString *message;//无数据说明

//重新加载按钮回调
@property (nonatomic, copy) void(^reloadButtonClickBlock)(UIButton *button);

@end
