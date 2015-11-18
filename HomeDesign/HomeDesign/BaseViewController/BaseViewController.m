//
//  BaseViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navigationBarView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, FUSONNAVIGATIONBAR_HEIGHT)];
    _navigationBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigationBarView];
    
    _titleImge = [[UIImageView alloc] initWithFrame:RECT(0, 30, SCREEN_WIDTH / 2.5, 25)];
    _titleImge.center = CGPointMake(SCREEN_WIDTH / 2, 40);
    [_navigationBarView addSubview:_titleImge];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
