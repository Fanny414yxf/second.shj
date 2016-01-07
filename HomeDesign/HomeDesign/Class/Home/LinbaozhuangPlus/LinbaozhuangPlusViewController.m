//
//  LinbaozhuangPlusViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/2.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "LinbaozhuangPlusViewController.h"
#import "iCarousel.h"

#define ITEM_SPACING 200

typedef NS_ENUM(NSInteger, LinBaoZhaungPlusMenu) {
    LinBaoZhaungPlusMenuZhengZhuangQuanBaoZero = 20,
    LinBaoZhaungPlusMenuPeiSongShenSuBaoYou,
    LinBaoZhaungPlusMenuShiGongKaoPuBuYanQi,
    LinBaoZhaungPlusMenuZhiLiangBaoZhengHuanBao
};

@interface LinbaozhuangPlusViewController ()<UIWebViewDelegate>
{
    NSArray *imagename;
    NSMutableArray *detailHTMLArr;
}

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIView *scrollView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) iCarousel *iCarouselView;
@property (nonatomic, strong) UIWebView *advertisingWebView;


@end

@implementation LinbaozhuangPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"拎包装PIUS";
    imagename = @[@"linbaozhuangplus_image1", @"linbaozhuangplus_header", @"linbaozhuangplus_image1", @"linbaozhuangplus_header", @"linbaozhuangplus_image1", @"linbaozhuangplus_header"];
    
    _headerImage = [[UIImageView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.34)];
    _headerImage.image = [UIImage imageNamed:@"linbaozhuangplus_header"];
    [self.view addSubview:_headerImage];
    
    _scrollView = [[UIView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT + SCREEN_HEIGHT * 0.34, SCREEN_WIDTH, SCREEN_HEIGHT * 0.42)];
    _scrollView.backgroundColor = [RGBColor colorWithHexString:@"#efefef"];
    [self.view addSubview:_scrollView];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    detailHTMLArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [imagename count]; i ++) {
        UIImage * image = [UIImage imageNamed:imagename[i]];
        [imageArr addObject:image];
//        [detailHTMLArr addObject:ZUNXIANGJIA_HTML];
    }
    
    
    _advertisingWebView = [[UIWebView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT * 0.05, SCREEN_WIDTH, SCREEN_HEIGHT * 0.35)];
    _advertisingWebView.center = CGPointMake(SIZE_W(_scrollView)/2, SIZE_H(_scrollView)/2);
    _advertisingWebView.delegate = self;
    [_advertisingWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, LINBAOZHUNAG_PLUS_HTML]]]];
    [_scrollView addSubview:_advertisingWebView];
    
    
    _menuView = [[UIView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT * 0.86, SCREEN_WIDTH, SCREEN_HEIGHT * 0.14)];
    _menuView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
    [self.view addSubview:_menuView];
    
    
    NSArray * arr = @[@"整装全包 0增项", @"配送神速还包邮", @"施工靠谱不延期", @"品质保证还环保"];
    for (int i = 0; i < 4; i ++) {
        CGFloat with = (SCREEN_WIDTH - 100) / 4;
        CGFloat frame_y = (_menuView.frame.size.height - with) / 2;
        UIButton *button = [[UIButton alloc] initWithFrame:RECT(20 + i * (with + 20), frame_y, with, with)];
        [button setImage:[UIImage imageNamed:@"linbaozhuangyuan"] forState:UIControlStateNormal];
        button.tag = 20 + i;
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
    NSArray *linkArr = @[LINBAOZHUANG_PLUS_A, LINBAOZHUANG_PLUS_B, LINBAOZHUANG_PLUS_C, LINBAOZHUANG_PLUS_D];
    WebViewController *webVC = [[WebViewController alloc] init];
    switch (sender.tag) {
        case LinBaoZhaungPlusMenuZhengZhuangQuanBaoZero:
            webVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, linkArr[0]];
            webVC.titleString = @"整装全包0增项";
            break;
        case LinBaoZhaungPlusMenuPeiSongShenSuBaoYou:
            webVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, linkArr[1]];
            webVC.titleString = @"配送神速还包邮";
            NSLog(@"配送神速还包邮");
            break;
        case LinBaoZhaungPlusMenuShiGongKaoPuBuYanQi:
            webVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, linkArr[2]];
            webVC.titleString = @"施工靠谱不延期";
            NSLog(@"施工靠谱不延期");
            break;
        case LinBaoZhaungPlusMenuZhiLiangBaoZhengHuanBao:
            webVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, linkArr[3]];
            webVC.titleString = @"品质保证还环保";
            NSLog(@"品质保证还环保");
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    //捕获到的url格式：js-jump://title=月光族&url=http://www.baodu.com，然后分离出title和url
    NSURL *url = request.URL;
    
    NSString *str = [NSString stringWithFormat:@"%@",url];
    
    NSString *urlstr = url.path;
    if ([str hasPrefix:@"js-jump:"]) {
        if ([str length] > [@"js-jump://" length]) {
            
            NSRange range1;
            NSRange range2;
            range1 = [str rangeOfString:@"js-jump://title="];
            range2 = [str rangeOfString:@"&url"];
            NSInteger length = range2.location - range1.length ;
            NSString *ssss  = [str substringWithRange:NSMakeRange(range1.length, length)];
            NSString *title = [ssss stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.titleString = title;
            webVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL,urlstr];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    return YES;
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
    if ([NetWorking netWorkReachability]) {
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
    }    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [SVProgressHUD dismiss];
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
