//
//  HopShopViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/26.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HopShopViewController.h"
#import "WebViewJavascriptBridge.h"


@interface HopShopViewController ()<UIWebViewDelegate>

@property  WebViewJavascriptBridge *bridge;

@end

@implementation HopShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_bridge) {return;}
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        LxPrintf(@"对象从JS接收到的对象是%@", data);
        responseCallback(@"response message from JS");
    }];
    
    [_bridge registerHandler:@"" handler:^(id data, WVJBResponseCallback responseCallback) {
        LxPrintf(@"responsecallback is %@", data);
    }];
    
    [_bridge send:@"发送消息给接收   JS" responseCallback:^(id responseData) {
        LxPrintf(@"%@", responseData);
    }];
    [_bridge callHandler:@"testJavascriptHnaddler" data:@{@"foo":@"before ready"}];
    
    
}


- (void)renderButtons:(UIWebView *)webview
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *messgeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [messgeButton setTitle:@"" forState:UIControlStateNormal];
    [messgeButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    messgeButton.frame = RECT(10, SCREEN_WIDTH/ 3, 100, 30);
    messgeButton.titleLabel.font = font;
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webview];
    callbackButton.frame = CGRectMake(110, 414, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webview action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webview];
    reloadButton.frame = CGRectMake(210, 414, 100, 35);
    reloadButton.titleLabel.font = font;
    
}

- (void)sendMessage:(UIButton *)sender
{
    
}

- (void)callHandler:(UIButton *)sender
{
    
}

- (void)reload:(UIButton *)snnder
{
    
}
- (void)loadExamplePage:(UIWebView *)webview
{
    
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
