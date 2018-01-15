//
//  CountDownImg.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "CountDownImg.h"
#import <Masonry.h>
#import "DateTool.h"

#define KScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface CountDownImg ()
// 时
@property (nonatomic, assign) int hour;
// 分
@property (nonatomic, assign) int minute;
// 秒
@property (nonatomic, assign) int second;
// 内部倒计时是否开启
@property (nonatomic, assign) BOOL isTurnOnTimer;
// 倒计时定时器
@property (nonatomic, strong) dispatch_source_t _Nullable timer;
@end
@implementation CountDownImg

+ (instancetype)loadCountDownLabelWithSuperView:(UIView *)superView {
    CountDownImg *countImg = [[CountDownImg alloc] init];
    countImg.layer.cornerRadius = 30;
    countImg.layer.masksToBounds = YES;
    countImg.image = [UIImage imageNamed:@"sign_bg"];
    countImg.userInteractionEnabled = YES;
    countImg.isTurnOnTimer = NO;
    [superView addSubview:countImg];
    [countImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.trailing.equalTo(superView.mas_trailing).offset(30);
        make.bottom.equalTo(superView.mas_bottom).offset(-KScreenHeight/3);
    }];
    return countImg;
}
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.countDownLabel];
        [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(self);
        }];
    }
    return self;
}
#pragma mark - 开启倒计时定时器
-(void)startTimer:(NSString*)signTime{
    self.isTurnOnTimer = YES;
    //获取当前时间
    NSDate* currentDate = [NSDate date];
    //创建日期格式
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate* oldDate = [formater dateFromString:signTime];
    NSTimeInterval time = [oldDate timeIntervalSinceDate:currentDate];
    
    self.hour = ((int)time) % (3600*24) / 3600;
    self.minute = ((int)time) % (3600*24) % 3600/60;
    self.second = ((int)time) % (3600*24) % 3600 % 60;
    
    __weak typeof(&*self) weakSelf = self;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        weakSelf.second --;
        if (weakSelf.second == -1) {
            weakSelf.second = 59;
            weakSelf.minute -- ;
            if (weakSelf.minute == -1) {
                weakSelf.minute = 59;
                weakSelf.hour --;
            }
        }
        weakSelf.countDownLabel.text = [NSString stringWithFormat:@"倒计时 %d:%d:%d",weakSelf.hour,weakSelf.minute,weakSelf.second];
        weakSelf.countDownLabel.font = [UIFont systemFontOfSize:10];
        if (weakSelf.hour == 0 && weakSelf.minute == 0 && weakSelf.second == 0) {
            dispatch_cancel(self.timer);
            self.timer = nil;
            self.isTurnOnTimer = NO;
            if ([[signTime substringWithRange:NSMakeRange(11, 8)] isEqualToString:@"17:00:00"]) {
                weakSelf.countDownLabel.text = @"晚签";
            } else {
                weakSelf.countDownLabel.text = @"早签";
            }
        }
    });
    dispatch_resume(self.timer);
}

-(void)cancelTimer{
    if (self.isTurnOnTimer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    } else {
        NSLog(@"定时器未开启");
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

-(void)dealloc{
    NSLog(@"countImg delloc");
}

#pragma mark - gettre
-(UILabel *)countDownLabel{
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
        _countDownLabel.numberOfLines = 0;
        _countDownLabel.text = @"签到";
        _countDownLabel.textColor = [UIColor whiteColor];
    }
    return _countDownLabel;
}
@end
