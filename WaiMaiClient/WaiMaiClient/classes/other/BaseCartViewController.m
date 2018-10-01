//
//  BaseCartViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BaseCartViewController.h"


@interface BaseCartViewController ()


@end

@implementation BaseCartViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.userInteractionEnabled = YES;
}

- (void)shopCartView{
    if (!_cartView) {
        _cartView = [[ShopCartView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-74, SCREEN_HEIGHT-150, 64, 68)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapShopCartView)];
        [_cartView addGestureRecognizer:tap];
        
//        UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                                                                                action:@selector(doHandlePanAction:)];
//        [self.cartView addGestureRecognizer:panGestureRecognizer];
        [self.view addSubview:_cartView];
        [self.view bringSubviewToFront:_cartView];

    }
    
    int goodsCount = [SCUtil getGoodsCount];
    
    [_cartView setCount:goodsCount];
    
}

//- (void) doHandlePanAction:(UIPanGestureRecognizer *)paramSender{
//    
//    CGPoint point = [paramSender translationInView:self.view];
//    NSLog(@"X:%f;Y:%f   %.f  %.f",point.x,point.y,paramSender.view.center.y, paramSender.view.center.x);
//    
//    CGFloat y = paramSender.view.center.y;
//    CGFloat x = paramSender.view.center.x;
//    if (y <= 64+32) {
//        y = 64+32;
//    }else if (y > SCREEN_HEIGHT-32){
//        y = SCREEN_HEIGHT-32;
//    }
//    
//    if (x > SCREEN_WIDTH-32) {
//        x = SCREEN_WIDTH-32;
//    }else if (x<32){
//        x = 32;
//    }
//    
//    
//    
//    paramSender.view.center = CGPointMake(x + point.x, y + point.y);
//    [paramSender setTranslation:CGPointMake(0, 0) inView:self.view];
//    
//    
//}
//跳转  购物车
- (void)onTapShopCartView{
    ShopCartViewController *shopCartCtrl = [[ShopCartViewController alloc] init];
    ShopCartBaseModel *model = [[ShopCartManager shareManager] loadShopCartBaseModel];
    shopCartCtrl.cartBaseModel = model;
    [self.navigationController pushViewController:shopCartCtrl animated:YES];
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
