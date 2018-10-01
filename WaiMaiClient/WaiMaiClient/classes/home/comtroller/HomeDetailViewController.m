//
//  HomeDetailViewController.m
//  qk
//
//  Created by 王 on 2017/6/28.
//  Copyright © 2017年 qk. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()<UIWebViewDelegate>

@end

@implementation HomeDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([LanguageManager shareManager].language == 0) {
        [self setTopBarTitle:@"Detail"];
    }else{
        [self setTopBarTitle:@"详情"];
    }
    [self createwebView];
}

- (void)createwebView{
    _detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _detailWebView.opaque = NO;
    _detailWebView.backgroundColor = [UIColor whiteColor];
    _detailWebView.delegate = self;
    _detailWebView.scalesPageToFit = YES;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_detailUrl]];
    [_detailWebView loadRequest:request];
    [self.view addSubview:_detailWebView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
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
