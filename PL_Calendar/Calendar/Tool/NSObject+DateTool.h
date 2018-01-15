//
//  NSObject+DateTool.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (DateTool)

- (NSDateComponents *)aCertainDateComponents:(NSDate *)date calendar:(NSCalendar *)calendar;

- (UIView *)returnsItemsBackgroundView:(CGRect)rect Type:(NSInteger)isSelected;

- (NSString *)theTargetDateConversionStr:(NSDate *)date;

- (NSDate *)theTargetStringConversionDate:(NSString *)str;

- (NSInteger)getCurrentMonthForDays;

- (NSDate *)getAMonthFromDate:(NSDate *)date months:(NSInteger)number calendar:(NSCalendar *)calendar;

- (NSInteger)getNextNMonthForDays:(NSDate *)date;

- (NSInteger)getFirstDayWeekForMonth:(NSDate *)date calendar:(NSCalendar *)calendar;

@end
