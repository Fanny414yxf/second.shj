//
//  HomeCollectionReusableView.m
//  HomeDesign
//
//  Created by apple on 15/11/14.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeCollectionReusableView.h"
#import "YXFSegmentViwe.h"

typedef NS_ENUM(NSInteger, HomeHeaderMune) {
   HomeHeaderMuneYuanZhuangZhengPin = 0,           //原装正品
    HomeHeaderMuneZengXiangQuanMian,            //全项增免
    HomeHeaderMune0YanQi,                       //0延期
    HomeHeaderMuneHuanBaoBuDaBiaoQuanETuiKuan   //环保不达标全额退款
};

@interface HomeCollectionReusableView ()<YXFSegmentDataSource, YXFSegmentDelegate>
{
    CGRect oldRect;
}

@end

@implementation HomeCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    }
    return self;
}


@end
