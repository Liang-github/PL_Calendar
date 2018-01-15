//
//  CalendarCell.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "CalendarCell.h"
#import <Masonry.h>
#import "PLColor.h"

static CGFloat cellHeight;

@interface CalendarCell ()

@property (nonatomic, strong) UIImageView *tian;

@property (nonatomic, strong) UIImageView *ren;

@property (nonatomic, strong) UIImageView *di;


@end
@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        cellHeight = CGRectGetHeight(self.contentView.bounds);
    }
    return self;
}
- (void)setDataSource:(CalendarModel *)dataSource {
    if (dataSource.sign1.intValue != 0 || dataSource.sign2.intValue != 0 || dataSource.sign3.intValue != 0) {
        self.calendarLabel.textColor = RGBCOLOR(235, 54, 65);
    } else {
        self.calendarLabel.textColor = RGBCOLOR(109, 108, 129);
    }
    [dataSource.sign1 boolValue] ? [self.tian setHidden:NO] : [self.tian setHidden:YES];
    [dataSource.sign2 boolValue] ? [self.ren setHidden:NO] : [self.ren setHidden:YES];
    [dataSource.sign3 boolValue] ? [self.di setHidden:NO] : [self.di setHidden:YES];
}
- (void)layoutSubviews {
    [self.calendarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(cellHeight/2);
        make.leading.trailing.top.equalTo(self.contentView);
    }];
    [self.ren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).with.offset(2 + cellHeight/2);
        make.size.mas_equalTo(self.ren.image.size);
    }];
    [self.tian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(cellHeight/2);
        make.trailing.equalTo(self.ren.mas_leading);
        make.size.mas_equalTo(self.tian.image.size);
    }];
    [self.di mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(1 + cellHeight/2);
        make.leading.equalTo(self.ren.mas_trailing);
        make.size.mas_equalTo(self.di.image.size);
    }];
}
- (UILabel *)calendarLabel {
    if (!_calendarLabel) {
        _calendarLabel = [[UILabel alloc] init];
        _calendarLabel.font = [UIFont systemFontOfSize:12];
        _calendarLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_calendarLabel];
    }
    return _calendarLabel;
}
- (UIImageView *)tian {
    if (!_tian) {
        _tian = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_sky"]];
        _tian.hidden = YES;
        [self.contentView addSubview:_tian];
    }
    return _tian;
}
- (UIImageView *)ren {
    if (!_ren) {
        _ren = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_person"]];
        _ren.hidden = YES;
        [self.contentView addSubview:_ren];
    }
    return _ren;
}
- (UIImageView *)di {
    if (!_di) {
        _di = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_land"]];
        _di.hidden = YES;
        [self.contentView addSubview:_di];
    }
    return _di;
}
@end
