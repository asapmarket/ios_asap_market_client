//
//  UITableViewControllerExt.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UIViewControllerExt.h"
#import "UITableViewExt.h"
#import "NoDataView.h"

@interface UITableViewControllerExt : UIViewControllerExt<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableViewExt *tableView;
@property(nonatomic,assign)int pageSize;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)UITableViewStyle tableViewStyle;
@property(nonatomic,assign)BOOL canRefresh;
@property(nonatomic,assign)BOOL canLoadMore;
@property (nonatomic,strong)NoDataView *noDataView;
@property(nonatomic,assign)int page;

-(void)requestData:(BOOL)isLoadMore;
-(void)stopRefesh;
-(void)stopLoadMore;
-(void)reloadData;

-(void)animationWithScroll:(CGFloat)animationY;
-(void)animationEndWithScroll:(CGFloat)animationY;

@end
