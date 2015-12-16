//
//  WebViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/14.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:_webView];
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
