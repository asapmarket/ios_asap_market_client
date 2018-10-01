//
//  CYHomeBannerView.h
//  whcy
//
//  Created by 王 on 2018/4/8.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CYScrollViewSelectBlock)(NSInteger);
typedef void (^CYScrollViewCurrentIndex)(NSInteger);

@interface CYHomeBannerView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *slideImagesArray; // 存储图片的地址
@property (nonatomic, copy) CYScrollViewSelectBlock cyEcrollViewSelectAction; // 图片点击事件
@property (nonatomic, copy) CYScrollViewCurrentIndex cyCurrentIndex;// 此时的幻灯片图片序号
@property (nonatomic) NSNumber *autoTime; // 滚动时间

- (void)startLoading; // 加载初始化（必须实现）
// 或者
- (void)startLoadingByIndex:(NSInteger)index; // 加载初始化并制定初始图片

@end
