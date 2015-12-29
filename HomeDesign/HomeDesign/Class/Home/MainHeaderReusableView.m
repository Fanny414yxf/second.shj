//
//  MainHeaderReusableView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainHeaderReusableView.h"
#import "TimeFormatter.h"
#import "ITTHeader.h"


@interface MainHeaderReusableView ()
{
    NSString *timeStr;//结束时间
    BOOL timeEnd;//嗨款
    
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segementHeith;
@property (strong, nonatomic) IBOutlet UILabel *zunxiangjiaFont;
@property (nonatomic, strong) UIImageView *defaultImage;//没有轮播时

@end

@implementation MainHeaderReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        _adCycleScrollView.titleArr = @[@"原装正品", @"增项全免", @"延期赔付", @"环保承诺"];
        
        //*******轮播广告*******
        _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
        _adScorll.hidesForSinglePage = NO;
        _adScorll.autoScrollTimeInterval = 3;
        _adScorll.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        
        _defaultImage = [[UIImageView alloc] initWithFrame:RECT(0, 40, SCREEN_WIDTH, 164)];
        _defaultImage.contentMode = UIViewContentModeScaleToFill;
        _defaultImage.backgroundColor = [UIColor cyanColor];
        _defaultImage.hidden = YES;
        _defaultImage.image = [UIImage imageNamed:@"defaultimage"];
        [self addSubview:_defaultImage];
    
    }
    return self;
}


- (void)setReusableViewInfo:(MainModel *)info;
{
    _defaultImage.frame = RECT(0, 40, SCREEN_WIDTH, SIZE_H(_adScorll));
     NSMutableArray * imagesURLStrings = [NSMutableArray array];
     if (![info.advs isEqual:[NSNull null]] && (info.advs != nil)) {
        NSArray *adv = [NSArray arrayWithArray:(NSArray *)info.advs];
        
        for (NSDictionary *dic in adv) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,dic[@"cover_id"]];
            [imagesURLStrings addObject:imageUrl];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 _adScorll.imageURLStringsGroup = imagesURLStrings;
             });
         _defaultImage.hidden = YES;

     }else{
         _defaultImage.hidden = NO;

         [[SDImageCache sharedImageCache] clearMemory];
         [[SDImageCache sharedImageCache] cleanDisk];
         [[SDImageCache sharedImageCache] clearDisk];
         
         [imagesURLStrings removeAllObjects];
         
         _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
         _adScorll.imageURLStringsGroup = nil;
         LxPrintf(@"%@     %@",imagesURLStrings, _adScorll.imageURLStringsGroup);
     }
    if (![info.linbaozhuang isEqual:[NSNull null]]) {
        
    }
    if (![info.linbaozhuangPLUS isEqual:[NSNull null]]) {
        
    }
    if (![info.zunxiangjia isEqual:[NSNull null]]) {
        
    }
    if ([info.haikuan isEqual:[NSNull null]] || [info.haikuan isEqual:nil]) {
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
        _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
        
        timeEnd = YES;
    }else{
        NSDictionary *dic = (NSDictionary *)info.haikuan;
        NSString *count = dic[@"count"];
        NSString *end = [NSString stringWithFormat:@"%d",[dic[@"endtime"] integerValue]];
        timeStr = [TimeFormatter longTimeLongString:end];
        _remainingShop.text = [NSString stringWithFormat:@"剩余 %@ 套",count];
        if ([end integerValue] > 0) {
            _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
            [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(contDownTimeWithHfenmiaoTimerFireMethod:) userInfo:nil repeats:YES];
        }else{
            timeEnd = YES;
        }
    }
}


#pragma mark - 嗨款倒计时
/**
 *  嗨款倒计时
 *
 *  @param dateString1 当前时间
 *  @param dateString2 结束时间
 *
 *  @return 剩余 时分秒
 */
- (void)contDownTimeWithHfenmiaoTimerFireMethod:(NSTimer *)timer{
    BOOL timeStar = YES;
    
    if (timeEnd) {
        //计时器失效
        [timer invalidate];
    }
    //定义一个NSCalendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //结束时间
    NSDate *date = [TimeFormatter makeDateWithTimeString:timeStr];
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
        _countdown_h.text = [NSString stringWithFormat:@"%@",t];
        if ([h integerValue] < 10) {
            _countdown_h.text = [NSString stringWithFormat:@"%@",t];
        }
        _countdowm_m.text = [NSString stringWithFormat:@"%@",h];
        if ([miao integerValue] < 10) {
            _countdowm_m.text = [NSString stringWithFormat:@"%@",h];
        }
        _countdown_s.text = [NSString stringWithFormat:@"%@",fen];
        if ([fen integerValue] < 10) {
            _countdown_s.text = [NSString stringWithFormat:@"%@",fen];
        }
    }else if ([d second] == 0){
        //计时器失效
        [timer invalidate];
        //结束
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
        _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
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
