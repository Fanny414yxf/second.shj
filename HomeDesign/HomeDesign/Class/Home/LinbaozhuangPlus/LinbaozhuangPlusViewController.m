//
//  LinbaozhuangPlusViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/2.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "LinbaozhuangPlusViewController.h"
#import "iCarousel.h"
#import "LinbaozhangDetailViewController.h"

#define ITEM_SPACING 200

typedef NS_ENUM(NSInteger, LinBaoZhaungPlusMenu) {
    LinBaoZhaungPlusMenuZhengZhuangQuanBaoZero = 20,
    LinBaoZhaungPlusMenuPeiSongShenSuBaoYou,
    LinBaoZhaungPlusMenuShiGongKaoPuBuYanQi,
    LinBaoZhaungPlusMenuZhiLiangBaoZhengHuanBao
};

@interface LinbaozhuangPlusViewController ()<iCarouselDataSource, iCarouselDelegate>
{
    NSArray *imagename;
    NSMutableArray *detailHTMLArr;
}

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIView *scrollView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) iCarousel *iCarouselView;


@end

@implementation LinbaozhuangPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"拎包装PIUS";
    imagename = @[@"linbaozhuangplus_image1", @"linbaozhuangplus_header", @"linbaozhuangplus_image1", @"linbaozhuangplus_header", @"linbaozhuangplus_image1", @"linbaozhuangplus_header"];

    
    _headerImage = [[UIImageView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.34)];
    _headerImage.image = [UIImage imageNamed:@"linbaozhuangplus_header"];
    [self.view addSubview:_headerImage];
    
    _scrollView = [[UIView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT + SCREEN_HEIGHT * 0.34, SCREEN_WIDTH, SCREEN_HEIGHT * 0.51)];
    _scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_scrollView];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    detailHTMLArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [imagename count]; i ++) {
        UIImage * image = [UIImage imageNamed:imagename[i]];
        [imageArr addObject:image];
        [detailHTMLArr addObject:ZUNXIANGJIA_HTML];
    }
    
    _iCarouselView = [[iCarousel alloc] initWithFrame:RECT(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
    _iCarouselView.type = iCarouselTypeCoverFlow2;
    _iCarouselView.dataSource = self;
    _iCarouselView.delegate = self;
    [_scrollView addSubview:_iCarouselView];
    
    
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
    switch (sender.tag) {
        case LinBaoZhaungPlusMenuZhengZhuangQuanBaoZero:
            NSLog(@"整装全包 0增项");
            break;
        case LinBaoZhaungPlusMenuPeiSongShenSuBaoYou:
            NSLog(@"配送神速还包邮");
            break;
        case LinBaoZhaungPlusMenuShiGongKaoPuBuYanQi:
            NSLog(@"施工靠谱不延期");
            break;
        case LinBaoZhaungPlusMenuZhiLiangBaoZhengHuanBao:
            NSLog(@"品质保证还环保");
            break;
        default:
            break;
    }
}


#pragma mark - <iCarouselDataSource, iCarouselDelegate>
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [imagename count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imagename[index]]]];
    
    view.frame = CGRectMake(70, 80, SCREEN_WIDTH * 0.7, SCREEN_WIDTH * 0.5);
    return view;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return [imagename count];
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.iCarouselView.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * _iCarouselView.itemWidth);
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    LinbaozhangDetailViewController *detailVC = [[LinbaozhangDetailViewController alloc] init];
    detailVC.url = detailHTMLArr[index];
    [self.navigationController pushViewController:detailVC animated:YES];
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
