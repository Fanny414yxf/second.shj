//
//  WebViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/14.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebViewController ()<NJKWebViewProgressDelegate, UIWebViewDelegate>
{
    NJKWebViewProgressView *webViewProgressView;
    NJKWebViewProgress *webViewProgress;
    BOOL webCanGoBack;//wenbview是否可以返回，不可返回即navc出栈
    NSString *currentPageUrl;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.titleString;
    webCanGoBack = NO;
    _webView = [[UIWebView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:_webView];
    
    webViewProgress  = [[NJKWebViewProgress alloc] init];
    _webView.delegate = webViewProgress;
    webViewProgress.webViewProxyDelegate = self;
    webViewProgress.progressDelegate = self;
    
    CGRect navBounds = self.navigationBarView.bounds;
    CGRect barFrame = RECT(0, navBounds.size.height - 2, navBounds.size.width, 2);
    
    webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [webViewProgressView setProgress:0 animated:YES];
    [self loadBidu];
    [self.navigationBarView addSubview:webViewProgressView];
    
}

- (void)loadBidu
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{    
//    NSString *str = [NSString stringWithFormat:@"%@", request.URL];
    return YES;
}


#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
//    [SVProgressHUD show];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error;
{
    
}


//冲洗返回按钮
- (void)backButton:(UIButton *)sender
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - <NJKWebViewProgressDelegate>
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [webViewProgressView setProgress:progress animated:YES];
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
