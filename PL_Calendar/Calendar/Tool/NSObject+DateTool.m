//
//  NSObject+DateTool.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "NSObject+DateTool.h"


static NSDictionary *dataSource;

@implementation NSObject (DateTool)


- (NSDateComponents *)aCertainDateComponents:(NSDate *)date calendar:(NSCalendar *)calendar {
    NSCalendarUnit dayInfoUnits = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:dayInfoUnits fromDate:date];
    return components;
}
- (UIView *)returnsItemsBackgroundView:(CGRect)rect Type:(NSInteger)isSelected {
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 3)/7;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemW, itemW)];
    view.center = CGPointMake(rect.origin.x/2, rect.origin.y/2);
    if (isSelected == 1) {
        view.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.7];
    } else {
        view.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
        view.layer.cornerRadius = itemW/2;
    }
    return view;
}
- (NSString *)theTargetDateConversionStr:(NSDate *)date {
    dataSource = @{@"01":@"一月",@"02":@"二月",@"03":@"三月",@"04":@"四月",@"05":@"五月",@"06":@"六月",
                   @"07":@"七月",@"08":@"八月",@"09":@"九月",@"10":@"十月",@"11":@"十一月",@"12":@"十二月"};
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-MM-dd";
    NSString *currentDateStr = [[dateFormat stringFromDate:date] substringWithRange:NSMakeRange(5, 2)];
    return dataSource[currentDateStr];
}

- (NSDate *)theTargetStringConversionDate:(NSString *)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:str];
    return date;
}
- (NSInteger)getCurrentMonthForDays {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}

- (NSDate *)getAMonthFromDate:(NSDate *)date months:(NSInteger)number calendar:(NSCalendar *)calendar {
    NSCalendarUnit dayInfoUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:dayInfoUnits fromDate:date];
    components.day = 1;
    if (number != 0) {
        components.month += number;
    }
    NSDate *nextMonthDate = [calendar dateFromComponents:components];
    return nextMonthDate;
}
- (NSInteger)getNextNMonthForDays:(NSDate *)date {
    NSInteger monthNum = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    return monthNum;
}
- (NSInteger)getFirstDayWeekForMonth:(NSDate *)date calendar:(NSCalendar *)calendar {
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    weekday --;
    if (weekday == 7) {
        return 0;
    } else {
        return weekday;
    }
}
@end
