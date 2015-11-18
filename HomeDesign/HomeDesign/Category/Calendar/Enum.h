//
//  Header.h
//  rili
//
//  Created by Johnson on 7/21/14.
//  Copyright (c) 2014 Johnson. All rights reserved.
//

#ifndef rili_Header_h
#define rili_Header_h

typedef enum
{
    PeriodTypeUnknown = 11,
    PeriodTypeAllDay,
    PeriodTypeMorning,
    PeriodTypeNoon,
    PeriodTypeAfternoon,
    PeriodTypeEvening
}PeriodType;

typedef enum
{
    WeekDayUnknown = 0,
    WeekDayMonday,
    WeekDayTuesday,
    WeekDayWednesday,
    WeekDayThurday,
    WeekDayFriday,
    WeekDaySaturday,
    WeekDaySunday
}WeekDay;

typedef struct
{
    NSInteger row;
    NSInteger column;
}GridIndex;

#endif
