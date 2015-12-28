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
    NSString *timeStr;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segementHeith;
@property (strong, nonatomic) IBOutlet UILabel *zunxiangjiaFont;
@end

@implementation MainHeaderReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        _adCycleScrollView.titleArr = @[@"原装正品", @"增项全免", @"延期赔付", @"环保承诺"];
        
        //*******轮播广告*******
        _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
        _adScorll.hidesForSinglePage = NO;
        _adScorll.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
    }
    return self;
}


- (void)setReusableViewInfo:(MainModel *)info;
{
     NSMutableArray * imagesURLStrings = [NSMutableArray array];
     if (![info.advs isEqual:[NSNull null]]) {
        NSArray *adv = [NSArray arrayWithArray:(NSArray *)info.advs];
        
        for (NSDictionary *dic in adv) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,dic[@"cover_id"]];
            [imagesURLStrings addObject:imageUrl];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 _adScorll.imageURLStringsGroup = imagesURLStrings;
             });
     }else{
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
    if (![info.haikuan isEqual:[NSNull null]]) {
        NSDictionary *dic = (NSDictionary *)info.haikuan;
        NSString *count = dic[@"count"];
        NSString *end = [NSString stringWithFormat:@"%d",[dic[@"endtime"] integerValue]];
        timeStr = [TimeFormatter longTimeLongString:end];
        _remainingShop.text = [NSString stringWithFormat:@"剩余 %@ 套",count];
        if ([end integerValue] > 0) {
            [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(contDownTimeWithHfenmiaoTimerFireMethod:) userInfo:nil repeats:YES];
        }else{
            _countdown_h.text = @"00";
            _countdowm_m.text = @"00";
            _countdown_s.text = @"00";
            _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
        }
    }else{
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
        _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
    }
}



- (void)clearTmpPics:(NSMutableArray *)configDataArray
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    //    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    
    float tmpSize = [[SDImageCache sharedImageCache] checkTmpSize];
    
    NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
    
    [configDataArray replaceObjectAtIndex:2 withObject:clearCacheName];
    
//    [configTableView reloadData];
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
//- (NSString *)intervalFromLastDate:(NSString *)dateString1 toTheDate:(NSString *) dateString2{
//    NSString *nowtime = [TimeFormatter dateFormatterWithDate_yyyyMMdd_HHmmss:[NSDate date]];
//    NSArray *timeArray1=[nowtime componentsSeparatedByString:@"."];
//    dateString1=[timeArray1 objectAtIndex:0];
//    
//    NSArray *timeArray2=[timeStr componentsSeparatedByString:@"."];
//    dateString2=[timeArray2 objectAtIndex:0];
//    
//    NSDateFormatter *date=[[NSDateFormatter alloc] init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *d1=[date dateFromString:dateString1];
//    
//    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
//    
//    NSDate *d2=[date dateFromString:dateString2];
//    
//    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
//    
//    NSTimeInterval cha=late2-late1;
//    NSString *timeString=@"";
//    NSString *house=@"";
//    NSString *min=@"";
//    NSString *sen=@"";
//    
//    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    秒
//    sen=[NSString stringWithFormat:@"%@", sen];
//    if ([sen integerValue] < 10) {
//        sen = [NSString stringWithFormat:@"0%@",sen];
//    }
//    
//    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    分
//    min=[NSString stringWithFormat:@"%@", min];
//    if ([min integerValue] < 10) {
//        min = [NSString stringWithFormat:@"0%@",min];
//    }
//    
//    //    小时
//    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
//    //        house = [house substringToIndex:house.length-7];
//    house=[NSString stringWithFormat:@"%@", house];
//    if ([house integerValue] < 10) {
//        house = [NSString stringWithFormat:@"0%@",house];
//    }
//    
//    _countdown_h.text = house;
//    _countdowm_m.text = min;
//    _countdown_s.text = sen;
//    if (house == 0 && min == 0 && sen == 0) {
//        _countdown_h.text = @"00";
//        _countdowm_m.text = @"00";
//        _countdown_s.text = @"00";
//    }
//    
//    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
//    
//    return timeString;
//}

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
    NSDate *date = [TimeFormatter makeDateWithTimeString:timeStr];
    NSDate *newtime = [NSDate date];
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
        //结束
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
    }else{
        //计时器失效
        [timer invalidate];
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
