//
//  HomeCollectionReusableView.m
//  HomeDesign
//
//  Created by apple on 15/11/14.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeCollectionReusableView.h"
#import "YXFSegmentViwe.h"
#import "SDCycleScrollView.h"


typedef NS_ENUM(NSInteger, HomeHeaderMune) {
   HomeHeaderMuneYuanZhuangZhengPin = 0,           //原装正品
    HomeHeaderMuneZengXiangQuanMian,            //全项增免
    HomeHeaderMune0YanQi,                       //0延期
    HomeHeaderMuneHuanBaoBuDaBiaoQuanETuiKuan   //环保不达标全额退款
};

@interface HomeCollectionReusableView ()<YXFSegmentDataSource, YXFSegmentDelegate, SDCycleScrollViewDelegate>
{
    CGRect oldRect;
}

@end

@implementation HomeCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
        self.layer.cornerRadius = 7.5;
        
        // 情景二：采用网络图片实现
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];

        YXFSegmentViwe *segemntView = [[YXFSegmentViwe alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 40) titleArr:@[@"原装正品", @"增项全免", @"0延期", @"环保不达标全额退款"]];
        segemntView.dataSource = self;
        segemntView.delegate = self;
        segemntView.backgroundColor = [RGBColor colorWithHexString:@"#52b615"];
        [segemntView handleButtonAction:^(NSInteger tag) {
            switch (tag) {
                case HomeHeaderMuneYuanZhuangZhengPin:
                    NSLog(@"原装整平");
                    break;
                    case HomeHeaderMuneZengXiangQuanMian:
                    NSLog(@"2222222");
                    break;
                    case HomeHeaderMune0YanQi:
                    NSLog(@"3333333333");
                    break;
                    case HomeHeaderMuneHuanBaoBuDaBiaoQuanETuiKuan:
                    NSLog(@"3333333333");
                    break;
                    
                default:
                    break;
            }
        }];
        [self addSubview:segemntView];
        
        
        SDCycleScrollView *adImagaCycleScollView = [SDCycleScrollView cycleScrollViewWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(segemntView), SCREEN_WIDTH, frame.size.height - SIZE_H(segemntView)) imageURLStringsGroup:nil];
        adImagaCycleScollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        adImagaCycleScollView.delegate = self;
        adImagaCycleScollView.placeholderImage = [UIImage imageNamed:@"pic"];
        [self addSubview:adImagaCycleScollView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            adImagaCycleScollView.imageURLStringsGroup = imagesURLStrings;
        });

        
    }
    return self;
}

#pragma mark - <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@" 选择了第%ld张图片", (long)index);
}

@end
