//
//  CountDownImg.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownImg : UIImageView
// 倒计时label
@property (nonatomic, strong) UILabel *_Nullable countDownLabel;

// 加载实例label
+ (nullable instancetype)loadCountDownLabelWithSuperView:(UIView *_Nullable)superView;
// 开启倒计时label内部的倒计时
- (void)startTimer:(NSString *_Nullable)signTime;
// 外部销毁定时器，释放内存的接口
- (void)cancelTimer;

@end
