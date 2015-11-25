//
//  TimeFormatter.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/24.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "TimeFormatter.h"
#import "ITTHeader.h"

@implementation TimeFormatter

+ (NSString *)longTimeString:(NSString *)timeStr
{
    double longTime = [timeStr doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longTime];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSString *)longTimeLongString:(NSString *)timeStr
{
    double longTime = [timeStr doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longTime];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)dateFormatterWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string = [formatter stringFromDate:date];
    return string;
}


+(NSDate *)makeDateWithTimeString:(NSString *)timeString
{
 //先定义一个遵循某个历法的日历对象
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //定义一个
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setYear:[[timeString substringToIndex:4] integerValue]];
    [dateComponentsForDate setMonth:[[timeString substringWithRange:NSMakeRange(5, 2)] integerValue]];
    [dateComponentsForDate setDay:[[timeString substringWithRange:NSMakeRange(8, 2)] integerValue]];
    [dateComponentsForDate setHour:[[timeString substringWithRange:NSMakeRange(11, 2)] integerValue]];
    [dateComponentsForDate setMinute:[[timeString substringWithRange:NSMakeRange(14, 2)] integerValue]];
    NSDate *date = [calendar dateFromComponents:dateComponentsForDate];
    return  date;
}


+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:HH dd-MM-yyyy"];
    NSString *oneDayString = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayString = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayString];
    NSDate *dateB =[dateFormatter dateFromString:anotherDayString];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return 1;//未来
    }else if (result == NSOrderedAscending){
        return -1;//过去
    }
    return 0;//相等
}

@end
