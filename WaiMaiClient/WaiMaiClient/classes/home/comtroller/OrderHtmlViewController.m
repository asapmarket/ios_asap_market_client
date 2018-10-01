//
//  OrderHtmlViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/7.
//  Copyright © 2017年 qk. All rights reserved.
//

#import "OrderHtmlViewController.h"
#import "WTabBarController.h"
#import "ShopCartManager.h"
#import "OederDetailViewController.h"

@interface OrderHtmlViewController ()<UIWebViewDelegate>

/** <#name#> */
@property (nonatomic, weak) UIWebView *webView ;
/** 是否为加载本地 */
@property (nonatomic, assign) Boolean isLoad;

@end

@implementation OrderHtmlViewController

- (UIWebView *)webView{
    if (!_webView) {
        
        UIWebView *webView = (UIWebView *)self.view;
        webView.delegate = self;
        
        webView.frame = self.view.bounds;
        _webView = webView;
    }
    return _webView;
}

- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isLoad) {
        // 本地加载
        [self initLoadRequest];
    } else {
        // 非本地
        [self initRequest];
    }
    
    
    
}

#pragma mark 加载本地页面
- (void)initLoadRequest
{
    NSString *path = [[NSBundle mainBundle] pathForResource:_urlStr ofType:@"html"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSString *basePath = [[NSBundle mainBundle]bundlePath];
    
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

#pragma mark 加载非本地页面
- (void)initRequest
{
    // 创建URL
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 发送请求加载网页
    [self.webView loadRequest:request];
}

- (OrderHtmlViewController *)initLoadRequestWithTitle:(NSString *)title url:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
        self.title = title;
        _isLoad = YES;
    }
    return self;
}

- (OrderHtmlViewController *)initRequestWithTitle:(NSString *)title url:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
        self.title = title;
        _isLoad = NO;
    }
    return self;
}

//支付失败：http://123.56.234.98/app/order/pay_ret://paypal?state=fail&orderId=9bb82fcb8a4d49a3b9cf60ca02189bd4
//
//支付成功：
//http://123.56.234.98/app/order/pay_ret://paypal?state=success&orderId=9bb82fcb8a4d49a3b9cf60ca02189bd4
//
//支付取消：
//http://123.56.234.98/app/order/pay_ret://paypal?state=cancel&orderId=9bb82fcb8a4d49a3b9cf60ca02189bd4
#pragma mark --webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    if (urlString != nil && [urlString rangeOfString:@"pay_ret://paypal?"].length > 0) {
        [MBProgressHUD hideHUD];
        NSString *urlStr = [[NSURL URLWithString:urlString] query];
        NSLog(@"urlStr =%@",urlStr);
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *array = [urlStr componentsSeparatedByString:@"&"];
        for (NSString *params in array) {
            NSArray *subArray = [params componentsSeparatedByString:@"="];
            [dict setObject:[subArray objectAtIndex:1] forKey:[subArray objectAtIndex:0]];
        }
        
        NSString *state = [dict objectForKey:@"state"];
        NSString *order_id = [dict objectForKey:@"orderId"];
        if ([state isEqualToString:@"success"]) {
            [self arlertShowWithText:NSLocalizedString(kpaySuccess, nil)];
            [[ShopCartManager shareManager] clearShopCart];
            
            OederDetailViewController *orderDetail = [[OederDetailViewController alloc] init];
            orderDetail.isPay = YES;
            orderDetail.orderId = order_id;
            [self.navigationController pushViewController:orderDetail animated:YES];
        }else if ([state isEqualToString:@"fail"]){
            [self arlertShowWithText:NSLocalizedString(kPayFail, nil)];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([state isEqualToString:@"cancle"]){
            [self arlertShowWithText:NSLocalizedString(kPayFail, nil)];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
        
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
    [self arlertShowWithText:@"支付失败"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
