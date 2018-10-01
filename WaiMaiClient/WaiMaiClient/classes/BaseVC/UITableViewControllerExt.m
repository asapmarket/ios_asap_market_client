//
//  UITableViewControllerExt.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UITableViewControllerExt.h"
#import "RefreshHeader.h"
#import <MJRefresh/MJRefreshFooter.h>
#import "HudCustomView.h"

@interface UITableViewControllerExt ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)HudCustomView *hudView;
@property(nonatomic,assign)BOOL isFirstRequestData;
@end

@implementation UITableViewControllerExt

-(void)viewFirstAppear{
    self.isFirstRequestData=YES;
    [self requestData:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.dataArray=[[NSMutableArray alloc]init];
    self.page=1;
    self.pageSize=10;
    self.tableViewStyle=UITableViewStylePlain;
    self.canRefresh=YES;
    self.canLoadMore = YES;
    
    _hudView=[[HudCustomView alloc]init];
    
    _noDataView=[[NoDataView alloc]init];
    _noDataView.type=NoDataTypeData;
    _noDataView.hidden=YES;
    WeakSelf;
    _noDataView.reloadButtonClickBlock = ^(UIButton *button) {
        [weakSelf refreshData];
    };
    
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkReachability:) name:kNotificationReachability object:nil];
}

-(void)setTableViewStyle:(UITableViewStyle)tableViewStyle{
    _tableViewStyle=tableViewStyle;
    
    if (self.tableView!=nil) {
        [self.tableView removeFromSuperview];
    }
    self.tableView=[[UITableViewExt alloc]initWithFrame:CGRectMake(0, self.topBarView.bottom, self.view.width, self.view.height-self.topBarView.height) style:tableViewStyle];
    self.tableView.backgroundColor=[UIColor background];
    self.tableView.autoresizingMask =UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 20, 0);
    self.tableView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 0, 20, 0);
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark -  Refresh Load 方法
-(void)setCanRefresh:(BOOL)canRefresh{
    _canRefresh=canRefresh;
    if (canRefresh&&self.tableView.mj_header==nil) {
        //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的requestData:NO方法）
        RefreshHeader *header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        WeakSelf;
        header.beginRefreshingCompletionBlock = ^{
            StrongSelf;
            self.noDataView.type=NoDataTypeData;
            [self.tableView reloadEmptyDataSet];
        };
        header.endRefreshingCompletionBlock = ^{
            StrongSelf;
            [self.tableView reloadEmptyDataSet];
        };
        //隐藏时间
        header.lastUpdatedTimeLabel.hidden = NO;
        //隐藏状态
        header.stateLabel.hidden = NO;
        //设置header
        self.tableView.mj_header = header;
    }
    else if (_canRefresh&&self.tableView.mj_header){
        self.tableView.mj_header.hidden=NO;
    }
    else{
        self.tableView.mj_header.hidden=YES;
    }
}

-(void)refreshData{
    [self requestData:NO];
}

-(void)setCanLoadMore:(BOOL)canLoadMore{
    _canLoadMore=canLoadMore;
    if (canLoadMore&&self.tableView.mj_footer==nil) {
        //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的requestData:YES方法）
        MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.mj_footer = footer;
    }
    else if(canLoadMore&&self.tableView.mj_footer){
        [self.tableView.mj_footer resetNoMoreData];
    }
    else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)loadMoreData{
    [self requestData:YES];
}

-(void)reloadData{
    if (self.tableView.mj_header&&self.tableView.mj_header.state==MJRefreshStateRefreshing) {
        [self stopRefesh];
    }
    if (self.tableView.mj_footer&&(self.tableView.mj_footer.state==MJRefreshStateRefreshing||self.tableView.mj_footer.state==MJRefreshStateNoMoreData)){
        [self stopLoadMore];
    }
    [self.tableView reloadData];
    [self.tableView reloadEmptyDataSet];
}

-(void)stopRefesh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

-(void)stopLoadMore{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.tableView.mj_footer.state==MJRefreshStateNoMoreData) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else if (self.tableView.mj_footer.state==MJRefreshStateRefreshing){
            [self.tableView.mj_footer endRefreshing];
        }
        
    });
   
}

#pragma mark -  数据获取 方法

-(void)networkReachability:(NSNotification *)sender{
    BOOL allReload=[sender.object boolValue];
    if (allReload) {
        [self requestData:NO];
    }
    else{
        if (self.navigationController.visibleViewController==self||[self.navigationController.visibleViewController.childViewControllers containsObject:self]) {
            [self requestData:NO];
        }
    }
}

-(void)requestData:(BOOL)isLoadMore{
    
}

-(void)requestDataFromCache{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark -  Animation 方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self animationWithScroll:scrollView.contentOffset.y];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self animationEndWithScroll:scrollView.contentOffset.y];
}

-(void)animationWithScroll:(CGFloat)animationY{
    
}

-(void)animationEndWithScroll:(CGFloat)animationY{
    
}

#pragma mark -  EmptyData 方法

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    if (_noDataView.hidden==YES) {
        return nil;
    }
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing||self.isFirstRequestData) {
        _hudView.isLoading=YES;
        self.isFirstRequestData=NO;
        return _hudView;
    }
    _hudView.isLoading=NO;
    return _noDataView;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView{
    
}

- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView{
    
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

-(BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

@end
