//
//  GuideViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/30.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * imageArr = @[@"guideImag1.jpg",@"guideImag2.jpg"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imageArr.count, SCREEN_HEIGHT);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    for (NSInteger i = 0; i < [imageArr count]; i ++) {
        UIImageView * guideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        guideImageView.image = [UIImage imageNamed:imageArr[i]];
        [self.scrollView addSubview:guideImageView];
    }
    
    UIButton * comingInterfaceBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    comingInterfaceBut.center = CGPointMake((SCREEN_WIDTH * (imageArr.count - 1)) + (SCREEN_WIDTH / 2), SCREEN_HEIGHT - 30);
    [comingInterfaceBut setTitle:@"点击进入" forState:UIControlStateNormal];
    [comingInterfaceBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comingInterfaceBut addTarget:self action:@selector(comingInterfece:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:comingInterfaceBut];
    [self.view addSubview:self.scrollView];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    _pageControl.center = CGPointMake(CGRectGetMidX(self.view.frame), SCREEN_HEIGHT - 50);
    _pageControl.numberOfPages = imageArr.count;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pageControl];
}


#pragma mark - process
- (void)comingInterfece:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(removeGuideWindow)]) {
        [_delegate removeGuideWindow];
    }
}

- (void)pageAction:(UIPageControl *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pageControlSetPage:)]) {
        [_delegate pageControlSetPage:sender];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger current = scrollView.contentOffset.x / SCREEN_WIDTH;
    _pageControl.currentPage = current;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
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
