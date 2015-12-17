//
//  SandiTiyanViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/9.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "SandiTiyanViewController.h"

@interface SandiTiyanViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation SandiTiyanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"3D体验";
    self.url = SANDITIYAN_HTML;
//    _webView = [[UIWebView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SANDITIYAN_HTML]]];
//    [self.view addSubview:_webView];
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
