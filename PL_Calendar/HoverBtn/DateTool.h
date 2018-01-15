//
//  DateTool.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject

// 判断当前时间是否在一段时间内
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour fromMinute:(NSInteger)fromMin toHour:(NSInteger)toHour toMinute:(NSInteger)toMin;
// 日期转字符串
+ (NSString *)theTargetDateConversionStr:(int)dateType;

@end
