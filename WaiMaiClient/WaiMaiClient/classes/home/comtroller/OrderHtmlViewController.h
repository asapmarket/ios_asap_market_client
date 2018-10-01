//
//  OrderHtmlViewController.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/7.
//  Copyright © 2017年 qk. All rights reserved.
//

#import "UIViewControllerExt.h"

@interface OrderHtmlViewController : UIViewControllerExt

/** 连接URl */
@property (nonatomic, strong) NSString *urlStr;



/**
 *  初始化htmlView 加载本地html
 *
 *  @param title  标题
 *  @param urlStr 连接地址
 *
 *  @return htmlView 对象
 */
- (OrderHtmlViewController *)initLoadRequestWithTitle:(NSString *)title url:(NSString *)urlStr;

/**
 *  初始化htmlView 加载html
 *
 *  @param title  标题
 *  @param urlStr 连接地址
 *
 *  @return htmlView 对象
 */
- (OrderHtmlViewController *)initRequestWithTitle:(NSString *)title url:(NSString *)urlStr;


@end
