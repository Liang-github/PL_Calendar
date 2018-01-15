//
//  ViewController.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "ViewController.h"
#import "CalendarView.h"
#import "CountDownImg.h"
#import "UIView+Animation.h"
#import <Masonry.h>
#import "NSObject+DateTool.h"
@interface ViewController ()<CalendarViewDelegate>

// 日历
@property (nonatomic, strong) CalendarView *calendarView;
// 倒计时按钮
@property (nonatomic, strong) CountDownImg *signImg;
// sign1
@property (nonatomic, copy) NSString *sign1;
// sign2
@property (nonatomic, copy) NSString *sign2;
// sign3
@property (nonatomic, copy) NSString *sign3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self calendarView];
    [self signImg];
    
}
#pragma mark - 按钮点击
- (void)tapSign:(UITapGestureRecognizer *)sender {
    if (!self.calendarView.hidden) {
        return;
    }
    [self.signImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing).offset(-15);
        
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.calendarView.hidden = NO;
    [self.calendarView curlDown:1];
    [self.calendarView refreshCalendarData:[self creatRandomData]];
}
#pragma mark - 生成随机数据
- (NSMutableArray *)creatRandomData {
    NSMutableArray *dataSource = [NSMutableArray array];
    NSUInteger monthDays = [self getCurrentMonthForDays];
    for (int i = 0; i < monthDays; i++) {
        self.sign1 = [NSString stringWithFormat:@"%u",arc4random()%2];
        self.sign2 = [NSString stringWithFormat:@"%u",arc4random()%2];
        self.sign3 = [NSString stringWithFormat:@"%u",arc4random()%2];
        NSDictionary* dict = @{@"sign1":self.sign1,
                               @"sign2":self.sign2,
                               @"sign3":self.sign3};
        [dataSource addObject:dict];
    }
    
    return dataSource;
}
-(void)calendarHidden:(id)sender{
    [self.signImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view.mas_trailing).with.offset(30);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.calendarView.hidden = YES;
    [self.calendarView curUpAndAway:1];
}

-(CalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [CalendarView loadingCalendarView:self superView:self.view];
        _calendarView.hidden = YES;
    }
    return _calendarView;
}

-(CountDownImg *)signImg{
    if (!_signImg) {
        _signImg = [CountDownImg loadCountDownLabelWithSuperView:self.view];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSign:)];
        tap.numberOfTapsRequired = 1;
        [_signImg addGestureRecognizer:tap];
    }
    return _signImg;
}

@end
