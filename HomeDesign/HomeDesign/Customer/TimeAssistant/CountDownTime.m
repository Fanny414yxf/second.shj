//
//  CountDownTime.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CountDownTime.h"

@implementation CountDownTime

+ (void)contDownTimeWithHfenmiao{
    BOOL timeStar = YES;
    //定义一个NSCalendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //当前时间
    NSDate *currentTime = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
