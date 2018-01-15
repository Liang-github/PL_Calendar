//
//  CalendarFootView.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "CalendarFootView.h"
#import <Masonry.h>

@interface CalendarFootView ()

@property (nonatomic, strong) UIImageView *bgImg;

@end
@implementation CalendarFootView

- (void)layoutSubviews {
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.top.equalTo(self);
    }];
}
- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_footer_bg"]];
        [self addSubview:_bgImg];
    }
    return _bgImg;
}
@end
