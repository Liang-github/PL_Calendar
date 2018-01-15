//
//  UIView+Animation.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/15.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
float radiansForDegress (int degress);

@interface UIView (Animation)
// 位移
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callBack:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapback;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapback delegate:(id)delegate callBack:(SEL)method;
// 3D旋转
- (void)rotateWithCenterPoint:(CGPoint)point angle:(float)angle duration:(float)secs;
// 淡入
- (void)sadeInDuration:(float)secs finish:(void(^)(void))finishBlock;
// 淡出
- (void)sadeOutDuration:(float)secs finish:(void(^)(void))finishBlock;
// 旋转
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callBack:(SEL)method;
// 缩放
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callBack:(SEL)method;
// 顺时针旋转
- (void)spinClockwise:(float)secs;
// 逆时针旋转
- (void)spinCounterClockwise:(float)secs;
// 反翻页效果
- (void)curlDown:(float)secs;
// 视图翻页后消失
- (void)curUpAndAway:(float)secs;
// 缩放到最后一点消失
- (void)drainAway:(float)secs;
// 将视图改变到一定透明度
- (void)changeAlpha:(float)newAlpha secs:(float)secs;
// 改变透明度结束动画后还原
- (void)pulse:(float)secs continuously:(BOOL)continuously;
// 以渐变的方式添加子控件
- (void)addSubviewWithFadeanimation:(UIView *)subview;
// 粒子动画
- (void)particleAnimationImage:(NSString *)image;

@end
