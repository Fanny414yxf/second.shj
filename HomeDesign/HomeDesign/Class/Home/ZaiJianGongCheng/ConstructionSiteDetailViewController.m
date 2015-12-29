//
//  ConstructionSiteDetailViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ConstructionSiteDetailViewController.h"

@interface ConstructionSiteDetailViewController ()

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation ConstructionSiteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.titleLabel.text  = @"工程详情";
    
    self.webView.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT - 45);
    
    
    UIButton *onLineButton = [[UIButton alloc] initWithFrame:RECT(0,  SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    [onLineButton setBackgroundColor:[RGBColor colorWithHexString:MAINCOLOR_GREEN] forState:UIControlStateNormal];
    [onLineButton setTitle:@"在线咨询" forState:UIControlStateNormal];
    [onLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onLineButton addTarget:self action:@selector(processOnLineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onLineButton];
    
}


- (void)processOnLineBtn:(UIButton *)sender
{
    WebViewController *onLinePopViewVC = [[WebViewController alloc] init];
    onLinePopViewVC.url = [UserInfo shareUserInfo].zaixianzixunLink;
    onLinePopViewVC.titleString = @"在线咨询";
    [self.navigationController pushViewController:onLinePopViewVC animated:YES];
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
