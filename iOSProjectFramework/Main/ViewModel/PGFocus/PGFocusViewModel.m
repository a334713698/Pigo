//
//  PGFocusViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/12.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusViewModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <WatchConnectivity/WatchConnectivity.h>


@interface PGFocusViewModel()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PGFocusViewModel


- (void)setCurrentFocusState:(PGFocusState)currentFocusState{
    PGUserModelInstance.currentFocusState = currentFocusState;
    
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
            cdLabel.text= [NSString stringWithFormat:@"%02ld:00",PGConfigMgr.TomatoLength];
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
                UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"\n确定中止任务吗？" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertVC addAction:[UIAlertAction actionWithTitle:@"确定中止" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf settingFocuseEndTime:0];
                    [weakSelf timerInvalidate];
                    weakSelf.currentFocusState = PGFocusStateWillFocus;
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:@"手抖了" style:UIAlertActionStyleDefault handler:nil]];
                [TOPVC presentViewController:alertVC animated:YES completion:nil];
                return [RACSignal empty];
            }];
            
            [self startFocus];
        }
            break;
        case PGFocusStateWillShortBreak:
            //准备短时休息
        {
            cdLabel.text= [NSString stringWithFormat:@"%02ld:00",PGConfigMgr.ShortBreak];
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
            cdLabel.text= [NSString stringWithFormat:@"%02ld:00",PGConfigMgr.LongBreak];
            leftButton.pg_state = PGFocusButtonStateStartRest;
            rightButton.pg_state = PGFocusButtonStateNext;
            
            centerButton.pg_state = PGFocusButtonStateHidden;
            
            leftButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",leftButton.currentTitle);
                weakSelf.currentFocusState = PGFocusStateLongBreaking;
                return [RACSignal empty];
            }];
            
            rightButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                NSLog(@"%@",rightButton.currentTitle);
                weakSelf.currentFocusState = PGFocusStateFocusing;
                return [RACSignal empty];
            }];
        }
            break;
        case PGFocusStateLongBreaking:
            //长时休息中
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
            
            [self startRest:PGFocusStateWillLongBreak];
        }
            break;
        default:
            DLog(@"无匹配");
            break;
    }
}

- (void)timerInvalidate{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

//完成一个番茄
- (void)finishATomato{
    [self vibrating];
    [PGUserModelInstance completeATomato];
    [self settingFocuseEndTime:0];
    if (self.updateCount) {
        self.updateCount();
    }
    [self chooseRestMode];
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
    __block NSInteger seconds = PGConfigMgr.TomatoLength * 60;
//    seconds = 3;
    NSDate *endTime;// 最后期限
    if (_endTimeStamp > [NSDate nowStamp]) {
        //继续进行
        seconds = _endTimeStamp - [NSDate nowStamp];
        endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
        self.cdLabel.text = [NSDate pg_secondsToHMS:[endTime timeIntervalSinceNow]];
    }else{
        //从头开始
        endTime = [NSDate dateWithTimeIntervalSinceNow:seconds+1];
        [self settingFocuseEndTime:[[endTime dateToTimeStamp] integerValue]];
        self.cdLabel.text= [NSDate pg_secondsToHMS:[endTime timeIntervalSinceNow]];
    }
    [self localNotiWithTimeIntervalSinceNow:seconds+1 alertBody:@"专注结束，休息一下吧" cate:PGLocalNotiCateIDCompleteTomato];
    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
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
    NSInteger timeLength;
    if (state == PGFocusStateWillShortBreak) {
        timeLength = PGConfigMgr.ShortBreak;
    }else if (state == PGFocusStateWillLongBreak){
        timeLength = PGConfigMgr.LongBreak;
    }else{
        NSLog(@"状态不对");
        return;
    }
    [self timerInvalidate];
    WS(weakSelf)
    //开始计时
    self.cdLabel.text= [NSString stringWithFormat:@"%02ld:00",timeLength];
    __block NSInteger seconds = timeLength * 60;
//    seconds = 1;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds+1]; // 最后期限
    [self localNotiWithTimeIntervalSinceNow:seconds+1 alertBody:@"休息结束，开始专注" cate:PGLocalNotiCateIDCompleteRest];
    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
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
- (void)localNotiWithTimeIntervalSinceNow:(NSTimeInterval)seconds alertBody:(NSString*)alertBody cate:(NSString*)cate{
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
    ln.applicationIconBadgeNumber++;
    ln.category = cate;
    
    //4.调度通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
}

- (void)chooseRestMode{
    if (PGUserModelInstance.currentTask.count > 0 && (PGUserModelInstance.currentTask.count%PGConfigMgr.LongBreakInterval == 0)) {
        //长时休息
        if (PGConfigMgr.AutomaticRest) {
            self.currentFocusState = PGFocusStateLongBreaking;
        }else{
            self.currentFocusState = PGFocusStateWillLongBreak;
        }
    }else{
        //短时休息
        if (PGConfigMgr.AutomaticRest) {
            self.currentFocusState = PGFocusStateShortBreaking;
        }else{
            self.currentFocusState = PGFocusStateWillShortBreak;
        }
    }
}

- (void)settingFocuseEndTime:(NSInteger)t{
    [USER_DEFAULT setInteger:t forKey:Focuse_EndTimeStamp];
    [USER_DEFAULT synchronize];
    if (!t) {
        _endTimeStamp = 0;
    }
}

@end
