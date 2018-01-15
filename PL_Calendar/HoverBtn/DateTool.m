//
//  DateTool.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour fromMinute:(NSInteger)fromMin toHour:(NSInteger)toHour toMinute:(NSInteger)toMin {
    NSDate *date8 = [self getCustomDateWithHour:fromHour andMinute:fromMin];
    NSDate *date23 = [self getCustomDateWithHour:toHour andMinute:toMin];
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8] == NSOrderedDescending && [currentDate compare:date23] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour andMinute:(NSInteger)minute {
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    // 设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:minute];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
    
}
// 日期转字符串
+ (NSString *)theTargetDateConversionStr:(int)dateType {
    NSDate *date = nil;
    switch (dateType) {
        case 0:
            date = [NSDate date];
            break;
        case 1:
            date = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
            break;
        case -1:
            date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];
            break;
            
        default:
            break;
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
}
@end
