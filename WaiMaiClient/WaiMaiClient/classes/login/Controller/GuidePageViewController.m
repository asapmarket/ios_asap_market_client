//
//  GuidePageViewController.m
//  qk
//
//  Created by 王 on 2017/7/14.
//  Copyright © 2017年 qk. All rights reserved.
//

#import "GuidePageViewController.h"

@interface GuidePageViewController ()<UIScrollViewDelegate>{
    
    NSArray *imageArray;
    
    UIPageControl *pageControl;
    
    UIImageView *imageView1;
    UIImageView *imageView2;
    UIImageView *imageView3;
}

@property (nonatomic, strong)  UIScrollView *scrollView;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    if (SCREEN_HEIGHT == 812) {
        imageArray = @[@"guidePage_x_1", @"guidePage_x_2", @"guidePage_x_3"];
    }else{
        imageArray = @[@"guidePage-1", @"guidePage-2", @"guidePage-3"];
    }
    [self loadGuidePages];
    
}

- (void)loadGuidePages{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator=YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 15 / 16, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16)];
    pageControl.numberOfPages = [imageArray count];
    [self.view addSubview:pageControl];
    
    imageView1 = [self createImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imageName:imageArray[0]];
    [_scrollView addSubview:imageView1];
    
    imageView2 = [self createImageViewWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imageName:imageArray[1]];
    [_scrollView addSubview:imageView2];
    
    imageView3 = [self createImageViewWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imageName:imageArray[2]];
    [_scrollView addSubview:imageView3];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    [imageView3 addGestureRecognizer:tap];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [imageArray count], SCREEN_HEIGHT);

}

- (void)imageViewTap{
    [self.view removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if ([self.delegate respondsToSelector:@selector(upgradeGiftViewCancel)]) {
        [self.delegate upgradeGiftViewCancel];
    }
}

- (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / SCREEN_WIDTH);
    
}


//引导页版本号

+ (BOOL)shouldShowGuidePage {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *oldVersion = [GuidePageViewController getGuidePageVersion];
    if ((oldVersion == nil) || ![oldVersion isEqualToString:appVersion]) {
        [self saveGuidePageVersion:appVersion];
        return YES;
    }
    return NO;
}

+ (NSUserDefaults *)userDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return defaults;
}

+ (void)saveGuidePageVersion:(NSString *)version {
    [[self userDefaults] setObject:version forKey:GuidePageVersionKey];
    [[self userDefaults] synchronize];
}

+ (NSString *)getGuidePageVersion {
    return [[self userDefaults] stringForKey:GuidePageVersionKey];
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
