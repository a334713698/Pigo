//
//  PGFocusViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/12.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusViewModel.h"
#import <AudioToolbox/AudioToolbox.h>


@interface PGFocusViewModel()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PGFocusViewModel

//- (void)setCurrentFocusState:(PGFocusState)currentFocusState cdLabel:(UILabel*)cdLabel leftButton:(PGFocusButton*)leftButton centerButton:(PGFocusButton*)centerButton rightButton:(PGFocusButton*)rightButton{
- (void)setCurrentFocusState:(PGFocusState)currentFocusState{
    PGCountdownLabel* cdLabel = self.cdLabel;
    PGFocusButton* leftButton = self.leftButton;
    PGFocusButton* rightButton = self.rightButton;
    PGFocusButton* centerButton = self.centerButton;
    WS(weakSelf)
    _currentFocusState = currentFocusState;
    switch (currentFocusState) {
        case PGFocusStateWillFocus:
            //准备专注
        {
            cdLabel.text= [NSString stringWithFormat:@"%ld:00",PGConfigMgr.TomatoLength];
            leftButton.pg_state = PGFocusButtonStateHidden;
            rightButton.pg_state = PGFocusButtonStateHidden;
            
            centerButton.pg_state = PGFocusButtonStateStartFocus;
            
            centerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",centerButton.currentTitle);
                weakSelf.currentFocusState = PGFocusStateFocusing;
                return [RACSignal empty];
            }];
        }
            break;
        case PGFocusStateFocusing:
            //专注中
        {
            leftButton.pg_state = PGFocusButtonStateHidden;
            rightButton.pg_state = PGFocusButtonStateHidden;
            centerButton.pg_state = PGFocusButtonStateObsolete;
            centerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",centerButton.currentTitle);
                [weakSelf timerInvalidate];
                weakSelf.currentFocusState = PGFocusStateWillFocus;
                return [RACSignal empty];
            }];
            
            [self startFocus];
        }
            break;
        case PGFocusStateWillShortBreak:
            //准备短时休息
        {
            cdLabel.text= [NSString stringWithFormat:@"%ld:00",PGConfigMgr.ShortBreak];
            leftButton.pg_state = PGFocusButtonStateStartRest;
            rightButton.pg_state = PGFocusButtonStateNext;
            
            centerButton.pg_state = PGFocusButtonStateHidden;
            
            leftButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",leftButton.currentTitle);
                weakSelf.currentFocusState = PGFocusStateShortBreaking;
                return [RACSignal empty];
            }];
            
            rightButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",rightButton.currentTitle);
                weakSelf.currentFocusState = PGFocusStateFocusing;
                return [RACSignal empty];
            }];
        }
            break;
        case PGFocusStateShortBreaking:
            //短时休息中
        {
            leftButton.pg_state = PGFocusButtonStateStopRest;
            rightButton.pg_state = PGFocusButtonStateNext;
            centerButton.pg_state = PGFocusButtonStateHidden;

            leftButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",leftButton.currentTitle);
                [weakSelf timerInvalidate];
                weakSelf.currentFocusState = PGFocusStateWillFocus;
                return [RACSignal empty];
            }];
            
            rightButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",rightButton.currentTitle);
                weakSelf.currentFocusState = PGFocusStateFocusing;
                return [RACSignal empty];
            }];

            [self startRest:PGFocusStateWillShortBreak];
        }
            break;
        case PGFocusStateWillLongBreak:
            //准备长时休息
        {
            
        }
            break;
        case PGFocusStateLongBreaking:
            //长时休息中
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)timerInvalidate{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

//完成一个番茄
- (void)finishATomato{
    [self vibrating];
    if (PGConfigMgr.AutomaticRest) {
        self.currentFocusState = PGFocusStateShortBreaking;
    }else{
        self.currentFocusState = PGFocusStateWillShortBreak;
    }
}

//休息结束
- (void)finishRest:(PGFocusState)state{
    if (state != PGFocusStateWillShortBreak && state != PGFocusStateWillLongBreak) {
        NSLog(@"状态不对");
        return;
    }
    [self vibrating];
    if (PGConfigMgr.AutomaticNext) {
        self.currentFocusState = PGFocusStateFocusing;
    }else{
        self.currentFocusState = PGFocusStateWillFocus;
    }
}

//开始专注
- (void)startFocus{
    [self timerInvalidate];
    WS(weakSelf)

    //开始计时
    self.cdLabel.text= [NSString stringWithFormat:@"%ld:00",PGConfigMgr.TomatoLength];
    __block NSInteger seconds = PGConfigMgr.TomatoLength * 60;
    seconds = 10;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds+1]; // 最后期限
    [self localNotiWithTimeIntervalSinceNow:seconds+1 alertBody:@"专注结束，休息一下吧"];
    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        DLog(@"倒计时");
        int interval = [endTime timeIntervalSinceNow];
        if(interval<=0){
            DLog(@"专注结束");
            [weakSelf timerInvalidate];
            [weakSelf finishATomato];
        }else{
            weakSelf.cdLabel.text = [NSDate pg_secondsToHMS:interval];
        }
    }];
    NSRunLoop* runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
}

//开始休息
- (void)startRest:(PGFocusState)state{
    if (state != PGFocusStateWillShortBreak && state != PGFocusStateWillLongBreak) {
        NSLog(@"状态不对");
        return;
    }
    [self timerInvalidate];
    WS(weakSelf)
    //开始计时
    self.cdLabel.text= [NSString stringWithFormat:@"%ld:00",PGConfigMgr.ShortBreak];
    __block NSInteger seconds = PGConfigMgr.ShortBreak * 60;
    seconds = 5;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds+1]; // 最后期限
    [self localNotiWithTimeIntervalSinceNow:seconds+1 alertBody:@"休息结束，下一个番茄"];
    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        DLog(@"倒计时");
        int interval = [endTime timeIntervalSinceNow];
        if(interval<=0){
            DLog(@"休息结束");
            [weakSelf timerInvalidate];
            [weakSelf finishRest:state];
        }else{
            weakSelf.cdLabel.text = [NSDate pg_secondsToHMS:interval];
        }
    }];
    NSRunLoop* runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
}

//手机震动
- (void)vibrating{
    if (PGConfigMgr.VibratingAlert) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

//本地通知
- (void)localNotiWithTimeIntervalSinceNow:(NSTimeInterval)seconds alertBody:(NSString*)alertBody{
    if(!PGConfigMgr.NotifyAlert){
        return;
    }
    //1.创建本地通知对象
    UILocalNotification* ln = [UILocalNotification new];
    
    //2.设置属性
    //2.1 设置通知弹出时间
    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    //2.2 设置通知内容
    ln.alertBody = alertBody;
    //2.3 设置图标右上角的角标通知信息数量
    ln.applicationIconBadgeNumber = 1;
    
    //4.调度通知
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
}

@end