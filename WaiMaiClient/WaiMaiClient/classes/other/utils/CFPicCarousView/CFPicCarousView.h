//
//  CFHotTableViewHeaderView.h
//  LiteratureOnLine
//
//  Created by TheMoon on 16/1/18.
//  Copyright (c) 2016年 CFJ. All rights reserved.
//
//  使用说明：
/**
 *  1.引入#import "CFPicCarousView.h"
 *  2.采用initWithFrame:方法初始化，传入要显示轮播图的位置和尺寸
 *  3.给picModels赋值，传入要显示的图片数组
 *  4.给netPic属性赋值，告诉本轮播视图加载的是本地图片还是网络图片，调用方法不同
 */
#import <UIKit/UIKit.h>


// 轻拍图片Block
typedef void (^TapCurrentImgBlock) (NSInteger index);

@interface CFPicCarousView : UIView
/**
 *  当前显示的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *currentImgView;
/**
 *  上一张
 */
@property (weak, nonatomic) IBOutlet UIImageView *preImgView;
/**
 *  下一张
 */
@property (weak, nonatomic) IBOutlet UIImageView *nextImgView;

// 数据源
@property (nonatomic, strong) NSMutableArray *picModels;
// 是否为网络图片
@property (nonatomic, assign, getter=isNetPic) BOOL netPic;

@property (nonatomic, copy) TapCurrentImgBlock myTapCurrentImgBlock;

/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer *timer;

- (void)startTimer;
- (void)removeTimer;
@end
