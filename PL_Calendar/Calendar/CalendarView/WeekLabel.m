//
//  WeekLabel.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "WeekLabel.h"
#import <Masonry.h>
#import "PLColor.h"
@implementation WeekLabel
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = RGBCOLOR(109, 108, 129);
        self.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = RGBCOLOR(226, 226, 226);
        [self addSubview:_sepLine];
    }
    return _sepLine;
}
@end
