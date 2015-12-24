//
//  TimeFormatter.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/24.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeFormatter : NSObject

/**
 *  long型字符串转换为Date 并格式化为      yyyy-MM-dd
 */
+ (NSString *)longTimeString:(NSString *)timeStr;

/**
 *  long型字符串转换为Date          yyyy-MM-dd HH:mm:ss
 *   从 now 开始
 */
+ (NSString *)longTimeLongString:(NSString *)timeStr;

/**
 *   格式   yyyy-MM-dd
 *   从 1970 开始
 */
+ (NSString *)longTimeLongStringWithyyyyMMdd:(NSString *)timeStr;

/**
 *  根据Date返回string yyyy-MM-DD HH:mm:ss
 *
 */
+(NSString *)dateFormatterWithDate_yyyyMMdd_HHmmss:(NSDate *)date;

/**
 *  根据Date返回string yyyy-MM-DD
 *
 */
+(NSString *)dateFormatterWithDate_yyyyMMdd:(NSDate *)date;



/**
 * 根据日期date 修改格式             yyyy-MM-dd HH:mm
 */
+ (NSString *)dateFormatterWithDate:(NSDate *)date;

/**
 *  根据字符串自定义时间
 *  @param timeString          传入格式 2015-11-20 12:00:00
 */
+ (NSDate *)makeDateWithTimeString:(NSString *)timeString;


/**
 *  比较两个时间的大小（即先 后）
 *  @param oneDay     时间1
 *  @param anotherDay 时间2
 *
 *  @return  1 将来   -1 过去  0 等于
 */
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;




@end
