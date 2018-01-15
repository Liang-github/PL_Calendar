//
//  CalendarView.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarViewDelegate <NSObject>

- (void)calendarHidden:(id)sender;

@end
@interface CalendarView : UIView

@property (nonatomic, weak) id<CalendarViewDelegate>
delegate;

// 获取日历界面
+ (instancetype)loadingCalendarView:(id<CalendarViewDelegate>)delegate superView:(UIView *)superView;

- (void)refreshCalendarData:(NSMutableArray *)dataDic;

- (void)releaseCalendarMemory;

@end
