//
//  LinbaozhuangPlusViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/2.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "LinbaozhuangPlusViewController.h"

@interface LinbaozhuangPlusViewController ()


@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIView *scrollView;
@property (nonatomic, strong) UIView *menuView;

@end

@implementation LinbaozhuangPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerImage = [[UIImageView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.34)];
    _headerImage.image = [UIImage imageNamed:@"linbaozhuangplus_header"];
    [self.view addSubview:_headerImage];
    
    _scrollView = [[UIView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT + SCREEN_HEIGHT * 0.34, SCREEN_WIDTH, SCREEN_HEIGHT * 0.51)];
    _scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_scrollView];
    
    _menuView = [[UIView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT * 0.86, SCREEN_WIDTH, SCREEN_HEIGHT * 0.14)];
    _menuView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
    [self.view addSubview:_menuView];
    
    NSArray * arr = @[@"整装全包 0增项", @"配送神速还包邮", @"施工靠谱不延期", @"品质保证还环保"];
    for (int i = 0; i < 4; i ++) {
        CGFloat with = (SCREEN_WIDTH - 100) / 4;
        CGFloat frame_y = (_menuView.frame.size.height - with) / 2;
        UIButton *button = [[UIButton alloc] initWithFrame:RECT(20 + i * (with + 20), frame_y, with, with)];
        [button setImage:[UIImage imageNamed:@"linbaozhuangyuan"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleLinBaoZhuangMenu:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, button.frame.size.width - 10, 40)];
        label.center = CGPointMake(button.frame.size.width / 2, button.frame.size.height / 2);
        label.textAlignment = NSTextAlignmentCenter;
        if (isSizeOf_3_5 || isSizeOf_4_0){
            label.font = FONT(11);
        }else if (isSizeOf_4_7){
            label.font = FONT(12);
        }else{
            label.font = FONT(14.5);
        }
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%@", arr[i]];
        label.numberOfLines = 0;
        [button addSubview:label];
        
    }
    
}


- (void)handleLinBaoZhuangMenu:(UIButton *)sender
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
