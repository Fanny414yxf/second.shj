//
//  MainHeaderReusableView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainHeaderReusableView.h"
#import "YXFSegmentViwe.h"
#import "SDCycleScrollView.h"



@interface MainHeaderReusableView ()<YXFSegmentDelegate, YXFSegmentDataSource, SDCycleScrollViewDelegate>

@property (strong, nonatomic) IBOutlet YXFSegmentViwe *adCycleScrollView;
@property (strong, nonatomic) IBOutlet SDCycleScrollView *adScorll;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segementHeith;
@end

@implementation MainHeaderReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {

        _adCycleScrollView.delegate = self;
        _adCycleScrollView.dataSource = self;
        _adCycleScrollView.titleArr = @[@"原装正品", @"增项全免", @"0延期", @"环保不达标全额退款"];
        
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];

        //*******轮播广告*******
        _adScorll.delegate = self;
        _adScorll.placeholderImage = [UIImage imageNamed:@"home_pic.jpg"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _adScorll.imageURLStringsGroup = imagesURLStrings;
        });
    }
    return self;
}

#pragma mark - <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@" 选择了第%ld张图片", (long)index);
    if (self.button) {
        self.button(index);
    }
}

- (IBAction)clickLingBaoZhuang:(id)sender {
        if (self.button) {
        self.button(ReusableTypeLinBaoZhuang);
    }
}
- (IBAction)clickLinBaoZhuangPLUS:(id)sender {
    if (self.button) {
        self.button(ReusableTypeLinBaoZhuangPLUS);
    }
}
- (IBAction)clickZunXiangJia:(id)sender {
    if (self.button) {
        self.button(ReusableTypeZunXiangJia);
    }
}
- (IBAction)clickHaiKuan:(id)sender {
    if (self.button) {
        self.button(ReusableTypeHaiKuan);
    }
}

- (void)handleButton:(BlockBtnClick)block
{
    self.button = block;
}


- (void)awakeFromNib {
//    if (isSizeOf_4_0) {
//        self.segementHeith.constant = 30;
//    }
    // Initialization code
}

@end
