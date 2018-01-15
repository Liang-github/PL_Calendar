//
//  CalendarView.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarHeaderView.h"
#import "CalendarFootView.h"
#import "CalendarCell.h"
#import "NSObject+DateTool.h"
#import "CalendarModel.h"
#import <Masonry.h>

#define KscreenHeight   [UIScreen mainScreen].bounds.size.height

static NSString * const collectionIdenter = @"colelctionIdenter";
static NSString * const collectionHeaderIdenter = @"collectionHeaderIdenter";
static NSString * const collectionFooterIdenter = @"collectionFooterIdenter";
static NSInteger COLLECTIONWIDTH = 240 + 20;
static CGFloat SCALE             = 1.1;
static CGFloat CELLSCALE         = 7.6;

@interface CalendarView ()<UICollectionViewDelegate, UICollectionViewDataSource, CalendarHeaderViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *calendarCollectionView;

@property (nonatomic, strong) CalendarHeaderView *headerView;
// 组头数据源
@property (nonatomic, strong) NSMutableArray *headerViewDataArray;
// 获取日历签到的数据源
@property (nonatomic, strong) NSMutableArray *calendarDateArray;
// 创建日历
@property (nonatomic, strong) NSCalendar *calendar;
// 当前的日期
@property (nonatomic, strong) NSDate *amountOf1_Date;
// 选中的cell
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) NSInteger dayNum;

@end
@implementation CalendarView

+ (instancetype)loadingCalendarView:(id<CalendarViewDelegate>)delegate superView:(UIView *)superView {
    KscreenHeight == 736 ? COLLECTIONWIDTH = 250 + 20 : COLLECTIONWIDTH;
    KscreenHeight == 736 ? SCALE = 1.25 : SCALE;
    CalendarView *calenderView = [[CalendarView alloc] init];
    calenderView.delegate = delegate;
    [superView addSubview:calenderView];
    [calenderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
        make.size.mas_equalTo(CGSizeMake(COLLECTIONWIDTH, COLLECTIONWIDTH*SCALE));
    }];
    return calenderView;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        self.amountOf1_Date = [self getAMonthFromDate:[NSDate date] months:0 calendar:self.calendar];
        self.dayNum = [self getFirstDayWeekForMonth:self.amountOf1_Date calendar:self.calendar];
        self.selectedIndex = [self getTheDateInCalendarTodaySubscript];
        [self addSubview:self.calendarCollectionView];
    }
    return self;
}
#pragma mark - 释放内存
- (void)releaseCalendarMemory {
    for (UIView *view in self.subviews) {
        if (NULL != view) {
            [view removeFromSuperview];
        }
    }
    [self removeFromSuperview];
}
#pragma mark - 暴露接口刷新UI
- (void)refreshCalendarData:(NSMutableArray *)dataDic {
    for (NSDictionary *dic in dataDic) {
        CalendarModel *model = [CalendarModel loadWithDict:dic];
        [self.calendarDateArray addObject:model];
    }
    [self.calendarCollectionView reloadData];
}
- (void)dealloc {
    NSLog(@"calendar dealloc");
}
#pragma mark - 返回今天日期在日历UI中的位置下标
- (NSInteger)getTheDateInCalendarTodaySubscript {
    NSCalendarUnit dayInfoUnits = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [self.calendar components:dayInfoUnits fromDate:[NSDate date]];
    
    return components.day - 1 + self.dayNum;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 装collectionView透视图需要的数据
    [self.headerViewDataArray addObject:self.amountOf1_Date];
    // 目标月的天数+星期数（这天星期几就加几）目的->布局cell时候能够让每个月1号对应上星期数
    return [self getCurrentMonthForDays] + self.dayNum;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    KscreenHeight == 736 ? CELLSCALE = 8 : CELLSCALE;
    CGFloat itemW = COLLECTIONWIDTH/CELLSCALE;
    return CGSizeMake(itemW, itemW);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdenter forIndexPath:indexPath];
    if (indexPath.item < self.dayNum) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
        return cell;
    } else {
        // 给item赋值indexPath.item - 第一天是周几 就可以知道这个月日期怎么赋值了
        NSString *calendarStr;
        // 方法定义如果是星期天返回0（为了日历布局）所以这里处理一下
        if (self.dayNum == 0) {
            calendarStr = [NSString stringWithFormat:@"%ld",(indexPath.item + 1)];
        } else {
            calendarStr = [NSString stringWithFormat:@"%ld",(indexPath.item + 1 - self.dayNum)];
        }
        item.calendarLabel.text = calendarStr;
        if (self.calendarDateArray.count != 0) {
            item.dataSource = self.calendarDateArray[indexPath.item - self.dayNum];
        }
        return item;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        CalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderIdenter forIndexPath:indexPath];
        headerView.delegate = self;
        headerView.month.text = [self theTargetDateConversionStr:_headerViewDataArray[indexPath.section]];
        [headerView changeStatusWeek:self.selectedIndex%7];
        return headerView;
    } else {
        CalendarFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionFooterIdenter forIndexPath:indexPath];
        return footView;
    }
}
#pragma mark - CelendarHeaderViewDelegate
- (void)cancelCalendar:(id)sender {
    if ([self.delegate respondsToSelector:@selector(calendarHidden:)]) {
        [self.delegate calendarHidden:self];
    }
}
- (UICollectionView *)calendarCollectionView {
    if (!_calendarCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0.5;
        flowLayout.headerReferenceSize = CGSizeMake(COLLECTIONWIDTH, 100);
        flowLayout.footerReferenceSize = CGSizeMake(COLLECTIONWIDTH, 0);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _calendarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, COLLECTIONWIDTH, COLLECTIONWIDTH*SCALE) collectionViewLayout:flowLayout];
        _calendarCollectionView.backgroundColor = [UIColor whiteColor];
        _calendarCollectionView.layer.cornerRadius = 5;
        _calendarCollectionView.layer.masksToBounds = YES;
        _calendarCollectionView.delegate = self;
        _calendarCollectionView.dataSource = self;
        
        [_calendarCollectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:collectionIdenter];
        [_calendarCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
        [_calendarCollectionView registerClass:[CalendarFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionFooterIdenter];
        [_calendarCollectionView registerClass:[CalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderIdenter];
    }
    return _calendarCollectionView;
}
- (NSMutableArray *)headerViewDataArray {
    if (!_headerViewDataArray) {
        _headerViewDataArray = [NSMutableArray array];
    }
    return _headerViewDataArray;
}
- (NSMutableArray *)calendarDateArray {
    if (!_calendarDateArray) {
        _calendarDateArray = [NSMutableArray array];
    }
    return _calendarDateArray;
}
@end
