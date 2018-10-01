//
//  HotFoodsView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HotFoodsView.h"

@implementation HotFoodsView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 137)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
//        _scrollView.pagingEnabled = YES;
        
        [self addSubview:_scrollView];

    }
    return self;
}

- (void)setHotFoodArray:(NSArray *)hotFoodArray{
    _hotFoodArray = hotFoodArray;
    int count = (int)hotFoodArray.count;
    if (count == 0){
        return;
    }
    for (int i=0; i<hotFoodArray.count; i++) {
        HotFoodsModel *model = hotFoodArray[i];
        UIView *typeView = [self createViewWithFrame:CGRectMake(i*93+10*(i+1), 0, 93, 127) typeModel:model];
        typeView.layer.borderColor = [UIColor hexStringToColor:@"#ebebeb"].CGColor;
        typeView.layer.borderWidth = 0.5;
        typeView.tag = 1000+i;
        [_scrollView addSubview:typeView];
    }
    
    if(103*count+10 < SCREEN_WIDTH){
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 137);
        
    }else{
        _scrollView.contentSize = CGSizeMake(103*count+10, 137);
    }
    
}

- (UIView *)createViewWithFrame:(CGRect)frame typeModel:(HotFoodsModel *)model{
    
    CGFloat viewW = frame.size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 93, 93)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.foods_image] placeholderImage:[UIImage imageNamed:@"组-16"]];
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 93+4, viewW, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor hexStringToColor:@"#333333"];
    label.font = [UIFont systemFontOfSize:12];
    if ([LanguageManager shareManager].language == 0) {
        label.text = model.foods_name_en;
    }else{
        label.text = model.foods_name_cn;
    }
    label.userInteractionEnabled = YES;
    [view addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeViewTap:)];
    [view addGestureRecognizer:tap];
    return view;
    
}

- (void)typeViewTap:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    NSInteger index = view.tag - 1000;
    if ([self.delegate respondsToSelector:@selector(foodViewDidClick:)]) {
        [self.delegate foodViewDidClick:_hotFoodArray[index]];
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
