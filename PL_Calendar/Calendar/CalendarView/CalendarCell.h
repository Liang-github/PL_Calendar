//
//  CalendarCell.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"

@interface CalendarCell : UICollectionViewCell


@property (nonatomic, strong) UILabel *calendarLabel;

@property (nonatomic, strong) CalendarModel *dataSource;

@end
