//
//  CalendarHeaderView.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekLabel.h"

@protocol CalendarHeaderViewDelegate <NSObject>

- (void)cancelCalendar:(id)sender;

@end

@interface CalendarHeaderView : UICollectionReusableView


@property (nonatomic, weak) id<CalendarHeaderViewDelegate> delegate;

@property (nonatomic, strong) WeekLabel *weekLabel;

@property (nonatomic, strong) UILabel *month;

- (void)changeStatusWeek:(NSInteger)index;


@end
