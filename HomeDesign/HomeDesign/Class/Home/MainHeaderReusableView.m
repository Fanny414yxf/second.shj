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

#import "TimeFormatter.h"
#import "ITTHeader.h"




@interface MainHeaderReusableView ()<YXFSegmentDelegate, YXFSegmentDataSource, SDCycleScrollViewDelegate>

@property (strong, nonatomic) IBOutlet YXFSegmentViwe *adCycleScrollView;
@property (strong, nonatomic) IBOutlet SDCycleScrollView *adScorll;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segementHeith;
@property (strong, nonatomic) IBOutlet UILabel *zunxiangjiaFont;
@end

@implementation MainHeaderReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
//        if (isSizeOf_3_5) {
//            _zunxiangjiaFont.font = FONT(8);
//        }else if (isSizeOf_4_0){
//            _zunxiangjiaFont.font = FONT(8);
//        }else{
//            _zunxiangjiaFont.font = FONT(10);
//        }

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
        _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            _adScorll.imageURLStringsGroup = imagesURLStrings;
//        });
    }
    return self;
}


- (void)setReusableViewInfo:(MainModel *)info;
{
    NSDictionary *dic = (NSDictionary *)info.haikuan;
    NSString *count = dic[@"count"];
    _remainingShop.text = [NSString stringWithFormat:@"剩余 %@ 套",count];
    _countdown_h.text = @"3";
    _countdowm_m.text = @"33";
    _countdown_s.text = @"42";
    
    NSArray *advs = [NSArray arrayWithArray:(NSArray *)info.advs];
    NSMutableArray * imagesURLStrings;
    for (NSDictionary *dic in advs) {
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,dic[@"cover_id"]];
        [imagesURLStrings addObject:imageUrl];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _adScorll.imageURLStringsGroup = imagesURLStrings;
    });
    
    
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(contDownTimeWithHfenmiaoTimerFireMethod:) userInfo:nil repeats:YES];
}



#pragma mark - 嗨款倒计时
- (void)contDownTimeWithHfenmiaoTimerFireMethod:(NSTimer *)timer{
    BOOL timeStar = YES;
    //定义一个NSCalendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //结束时间
    NSDate *date = [TimeFormatter makeDateWithTimeString:@"2015-11-27 10:30:00"];
    NSString *overDate = [dateFormatter stringFromDate:date];
    
    static NSInteger year;
    static NSInteger month;
    static NSInteger day;
    static NSInteger hour;
    static NSInteger minute;
    static NSInteger second;
    
    if (timeStar) {
        year = [[overDate substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[overDate substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[overDate substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[overDate substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[overDate substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[overDate substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStar= NO;
    }
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    
    //用来得到具体时间差  是为了统一成北京时间
    NSDate *overtime = [cal dateFromComponents:endTime];
    unsigned int uiitFalgs = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:uiitFalgs fromDate:today toDate:overtime options:0];
    NSString *t = [NSString stringWithFormat:@"%ld", (long)[d day]];
    if ([d day] < 10) {
        t = [NSString stringWithFormat:@"0%ld", (long)[d day]];
    }
    NSString *h = [NSString stringWithFormat:@"%ld", (long)[d hour]];
    if ([d hour] < 10) {
        h = [NSString stringWithFormat:@"0%ld", (long)[d hour]];
    }
    NSString *fen = [NSString stringWithFormat:@"%ld", (long)[d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld", (long)[d second]];
    if([d second] < 10) {
        miao = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    }
    if ([d second] > 0) {
        //没结束
        _countdown_h.text = [NSString stringWithFormat:@"%@",h];
        if ([h integerValue] < 10) {
            _countdowm_m.text = [NSString stringWithFormat:@"0%@",h];
        }
        _countdowm_m.text = [NSString stringWithFormat:@"%@",miao];
        if ([miao integerValue] < 10) {
            _countdowm_m.text = [NSString stringWithFormat:@"0%@",miao];
        }
        _countdown_s.text = [NSString stringWithFormat:@"%@",fen];
        if ([fen integerValue] < 10) {
            _countdown_s.text = [NSString stringWithFormat:@"%@",fen];
        }
    }else if ([d second] == 0){
        //结束
//        _timelabel.text = @"00:00:00";
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
    }else{
        //计时器失效
        [timer invalidate];
    }
}

- (void)setDelegate:(id<ReusableViewDelege>)delegate
{
    if (_delegate && [_delegate respondsToSelector:@selector(subViewDelegateMethods)]) {
        [_delegate subViewDelegateMethods];
    }
}

#pragma mark - <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@" 选择了第%ld张图片", (long)index);
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
