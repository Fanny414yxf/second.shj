//
//  CountDownTime.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CountDownTime.h"
#import "TimeFormatter.h"
#import "ITTHeader.h"

@implementation CountDownTime

+ (void)contDownTimeWithHfenmiaoTimerFireMethod:(NSTimer *)timer{
    BOOL timeStar = YES;
    //定义一个NSCalendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [TimeFormatter makeDateWithTimeString:@"2015-12-01 00:00:00"];
    ITTDay *overDate = [[ITTDay alloc] initWithDate:date];
    
    static NSInteger year;
    static NSInteger month;
    static NSInteger day;
    static NSInteger hour;
    static NSInteger minute;
    static NSInteger second;
    
    if (timeStar) {
        year = [overDate getYear];
        month = [overDate getMonth];
        day = [overDate getDay];
        hour = [overDate getHour];
        minute = [overDate getMinute];
        second = [overDate getSecond];
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
    NSString *t = [NSString stringWithFormat:@"%ld", [d day]];
    NSString *h = [NSString stringWithFormat:@"%ld", [d hour]];
    NSString *fen = [NSString stringWithFormat:@"%ld", [d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%ld",[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld", [d second]];
    if([d second] < 10) {
        miao = [NSString stringWithFormat:@"0%ld",[d second]];
    }
    if ([d second] > 0) {
        //没结束
    }else if ([d second] == 0){
        //结束
    }else{
        //计时器失效
        [timer invalidate];
    }
    
    LxPrintf(@"倒计时距离---------%@  %@  %@  %@", t,h,fen,miao);

}

@end
