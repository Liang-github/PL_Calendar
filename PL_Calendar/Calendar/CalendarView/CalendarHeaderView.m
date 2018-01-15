//
//  CalendarHeaderView.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "CalendarHeaderView.h"
#import "PLColor.h"
#import <Masonry.h>

#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
static CGFloat labelW;

@interface CalendarHeaderView ()

@property (nonatomic, strong) NSArray *weekArray;

@property (nonatomic, strong) UIImageView *bgImg;

@property (nonatomic, strong) UIButton *cancel;

@end
@implementation CalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeaderView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self);
        make.height.mas_equalTo(60);
    }];
    [self.month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgImg);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}
- (void)changeStatusWeek:(NSInteger)index {
    self.weekLabel = (WeekLabel *)[self viewWithTag:index];
    self.weekLabel.textColor = RGBCOLOR(235, 54, 65);
    self.weekLabel.sepLine.backgroundColor = RGBCOLOR(235, 54, 65);
}
- (void)cancelCalendar:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelCalendar:)]) {
        [self.delegate cancelCalendar:self];
    }
}
- (void)createHeaderView {
    _weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    labelW = (self.frame.size.width - 20)/7;
    for (int index = 0; index < 7; index ++) {
        self.weekLabel = [[WeekLabel alloc] initWithFrame:CGRectMake(10 + index*labelW, 60, labelW, self.frame.size.height - 65)];
        self.weekLabel.text = _weekArray[index];
        self.weekLabel.tag = index;
        [self addSubview:self.weekLabel];
    }
}
- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_header_bg"]];
        [self addSubview:_bgImg];
    }
    return _bgImg;
}
- (UILabel *)month {
    if (!_month) {
        _month = [[UILabel alloc] init];
        _month.font = [UIFont systemFontOfSize:16];
        _month.textColor = [UIColor whiteColor];
        _month.textAlignment = NSTextAlignmentCenter;
        [self.bgImg addSubview:_month];
    }
    return _month;
}
- (UIButton *)cancel {
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setImage:CONTENTFILEIMAGE(@"close") forState:UIControlStateNormal];
        _cancel.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_cancel addTarget:self action:@selector(cancelCalendar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancel];
    }
    return _cancel;
}
@end
