//
//  CYHomeBannerView.m
//  whcy
//
//  Created by 王 on 2018/4/8.
//  Copyright © 2018年 王. All rights reserved.
//

#import "CYHomeBannerView.h"
#import "UIImageViewExt.h"
#import "PageControl.h"

@interface CYHomeBannerView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PageControl *pageControl;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger tempPage;

@end

@implementation CYHomeBannerView

- (void)startLoading
{
    [self _initScrollView];
}

- (void)startLoadingByIndex:(NSInteger)index
{
    [self startLoading];
    _tempPage = index;
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (index + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark -scrollView Delegate-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWith/([_slideImagesArray count]+2))/pageWith) + 1;
    page --; //默认从第二页开始
    [self.pageControl setSelectedIndex:page];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ ([_slideImagesArray count]+2)) / pageWith) + 1;
    
    if (currentPage == 0) {
        if (self.cyCurrentIndex) {
            self.cyCurrentIndex(_slideImagesArray.count-1);
        }
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }else if(currentPage == _slideImagesArray.count + 1){
        if (self.cyCurrentIndex){
            self.cyCurrentIndex(0);
        }
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
         ];
    }else{
        if (self.cyCurrentIndex){
            self.cyCurrentIndex(currentPage-1);
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_tempPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * _slideImagesArray.count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    }else if(_tempPage == _slideImagesArray.count){
        [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height) animated:NO
         ];
    }
}

#pragma mark -PageControl Method-
- (void)turnPage:(NSInteger)page
{
    _tempPage = page;
    [self.scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (page + 1), 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark -定时器 Method-
- (void)runTimePage
{
    NSInteger page = self.pageControl.currentIndex;
    page ++;
    [self turnPage:page];
}


#pragma mark -private Methods-
- (void)_initScrollView
{
    if (_scrollView) {
        return;
    }
    _scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        if(self.slideImagesArray.count < 2){
            scrollView.scrollEnabled = NO;
        }
        [self addSubview:scrollView];
        scrollView;
    });
    
    _pageControl = ({
        PageControl *pageControl = [[PageControl alloc] initWithFrame:CGRectMake(_scrollView.width-self.slideImagesArray.count*14-27, _scrollView.height-18, 100, 15) andDotCount:self.slideImagesArray.count];
        if(self.slideImagesArray.count < 2){
            pageControl.hidden = YES;
        }
        [self addSubview:pageControl];
        pageControl;
    });

    for (NSInteger i = 0; i < _slideImagesArray.count; i++) {
        UIImageViewExt *slideImage = [[UIImageViewExt alloc] init];
        slideImage.contentMode = UIViewContentModeScaleAspectFill;
        [slideImage imageWithURL:[NSURL URLWithString:_slideImagesArray[i]]];
        slideImage.tag = i;
        slideImage.frame = CGRectMake(_scrollView.frame.size.width * i + _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        [slideImage addTarget:self action:@selector(ImageClick:)];
        [_scrollView addSubview:slideImage];// 首页是第0页,默认从第1页开始的。所以+_scrollView.frame.size.width
    }
    // 取数组最后一张图片 放在第0页
    UIImageViewExt *firstSlideImage = [[UIImageViewExt alloc] init];
    firstSlideImage.contentMode = UIViewContentModeScaleAspectFill;
    [firstSlideImage imageWithURL:[NSURL URLWithString:_slideImagesArray[_slideImagesArray.count - 1]]];
    firstSlideImage.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:firstSlideImage];
    // 取数组的第一张图片 放在最后1页
    UIImageViewExt *endSlideImage = [[UIImageViewExt alloc] init];
    endSlideImage.contentMode = UIViewContentModeScaleAspectFill;
    [endSlideImage imageWithURL:[NSURL URLWithString:_slideImagesArray[0]]];
    endSlideImage.frame = CGRectMake((_slideImagesArray.count + 1) * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:endSlideImage];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * (_slideImagesArray.count + 2), _scrollView.frame.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    if (self.slideImagesArray.count >= 2) {
        [self addTimer];
    }
}

-(void)addTimer{
    if (!self.autoTime) {
        self.autoTime = [NSNumber numberWithFloat:5.0f];
    }
    _myTimer = [NSTimer timerWithTimeInterval:[self.autoTime floatValue] target:self selector:@selector(runTimePage)userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.myTimer invalidate];
    self.myTimer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];
    });
}

- (void)ImageClick:(UIImageView *)sender
{
    if (self.cyEcrollViewSelectAction) {
        self.cyEcrollViewSelectAction(sender.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
