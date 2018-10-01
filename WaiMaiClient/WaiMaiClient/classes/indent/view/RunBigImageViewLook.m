//
//  RunBigImageViewLook.m
//  WaiMaiClient
//
//  Created by 王 on 2018/5/3.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunBigImageViewLook.h"

@interface RunBigImageViewLook ()<UIScrollViewDelegate>{
    UIScrollView   *scrollView;
    UIButton       *closeButton;
    BOOL scrollLeft;
}

@end

@implementation RunBigImageViewLook

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator=YES;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(SCREEN_WIDTH-70, TopBarHeight-44, 50, 30);
        [closeButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
        [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [closeButton addTarget: self action:@selector(closeButotnClick) forControlEvents:UIControlEventTouchUpInside];
        closeButton.layer.cornerRadius = 5;
        [self addSubview:closeButton];
    }
    return self;
}

- (void)closeButotnClick{
    [self removeFromSuperview];
}

- (void)setDetailModel:(RunOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [detailModel.imgs count], SCREEN_HEIGHT);
    for (int i = 0; i < [detailModel.imgs count]; i++)
    {
        RunOrderImgsModel *img = [RunOrderImgsModel mj_objectWithKeyValues:detailModel.imgs[i]];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:img.path]];
        [scrollView addSubview:imageView];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //Selected index's color changed.
    static float newx = 0;
    static float oldx = 0;
    newx= scrollView.contentOffset.x ;
    if (newx != oldx ) {
        if (newx > oldx) {
            scrollLeft = YES;
        }else if(newx < oldx){
            scrollLeft = NO;
        }
        oldx = newx;
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    if (scrollLeft&&(offset == SCREEN_WIDTH*([_detailModel.imgs count]-1))) {
        
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
