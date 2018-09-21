//
//  PGFocusingViewModel.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusingViewModel.h"

@interface PGFocusingViewModel()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PGFocusingViewModel

- (void)setCurrentFocusState:(PGFocusState)currentFocusState{
    WKInterfaceLabel* timeLab = self.timeLab;
    _currentFocusState = currentFocusState;
    switch (currentFocusState) {
        case PGFocusStateWillFocus:
            //准备专注
        {
            timeLab.text= [NSString stringWithFormat:@"%ld:00",WKConfigMgr.TomatoLength];

            [self setTopBtnState:PGFocusButtonStateStartFocus];
            [self setBottomBtnState:PGFocusButtonStateHidden];
            
            
//            topBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                NSLog(@"%@",centerButton.currentTitle);
//                weakSelf.currentFocusState = PGFocusStateFocusing;
//                return [RACSignal empty];
//            }];
        }
            break;
        case PGFocusStateFocusing:
            //专注中
        {
            [self setTopBtnState:PGFocusButtonStateObsolete];
            [self setBottomBtnState:PGFocusButtonStateHidden];

//            topBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                NSLog(@"%@",centerButton.currentTitle);
//                [weakSelf timerInvalidate];
//                weakSelf.currentFocusState = PGFocusStateWillFocus;
//                return [RACSignal empty];
//            }];
            
            [self startFocus];
        }
            break;
        case PGFocusStateWillShortBreak:
            //准备短时休息
        {
            timeLab.text= [NSString stringWithFormat:@"%ld:00",WKConfigMgr.ShortBreak];
            
            [self setTopBtnState:PGFocusButtonStateStartRest];
            [self setBottomBtnState:PGFocusButtonStateNext];
            
//            topBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                NSLog(@"%@",leftButton.currentTitle);
//                weakSelf.currentFocusState = PGFocusStateShortBreaking;
//                return [RACSignal empty];
//            }];
//
//            bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                NSLog(@"%@",rightButton.currentTitle);
//                weakSelf.currentFocusState = PGFocusStateFocusing;
//                return [RACSignal empty];
//            }];
        }
            break;
        case PGFocusStateShortBreaking:
            //短时休息中
        {
            [self setTopBtnState:PGFocusButtonStateStopRest];
            [self setBottomBtnState:PGFocusButtonStateNext];
            
//            topBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                NSLog(@"%@",leftButton.currentTitle);
//                [weakSelf timerInvalidate];
//                weakSelf.currentFocusState = PGFocusStateWillFocus;
//                return [RACSignal empty];
//            }];
//
//            bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//                NSLog(@"%@",rightButton.currentTitle);
//                weakSelf.currentFocusState = PGFocusStateFocusing;
//                return [RACSignal empty];
//            }];
            
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
//    [self vibrating];
    if (WKConfigMgr.AutomaticRest) {
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
//    [self vibrating];
    if (WKConfigMgr.AutomaticNext) {
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
    self.timeLab.text= [NSString stringWithFormat:@"%ld:00",WKConfigMgr.TomatoLength];
    __block NSInteger seconds = WKConfigMgr.TomatoLength * 60;
//    seconds = 10;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds+1]; // 最后期限
//    [self localNotiWithTimeIntervalSinceNow:seconds+1 alertBody:@"专注结束，休息一下吧"];
    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //        DLog(@"倒计时");
        int interval = [endTime timeIntervalSinceNow];
        if(interval<=0){
            DLog(@"专注结束");
            [weakSelf timerInvalidate];
            [weakSelf finishATomato];
        }else{
            weakSelf.timeLab.text = [NSDate pg_secondsToHMS:interval];
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
    self.timeLab.text= [NSString stringWithFormat:@"%ld:00",WKConfigMgr.ShortBreak];
    __block NSInteger seconds = WKConfigMgr.ShortBreak * 60;
//    seconds = 5;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds+1]; // 最后期限
//    [self localNotiWithTimeIntervalSinceNow:seconds+1 alertBody:@"休息结束，开始下一个番茄"];
    _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //        DLog(@"倒计时");
        int interval = [endTime timeIntervalSinceNow];
        if(interval<=0){
            DLog(@"休息结束");
            [weakSelf timerInvalidate];
            [weakSelf finishRest:state];
        }else{
            weakSelf.timeLab.text = [NSDate pg_secondsToHMS:interval];
        }
    }];
    NSRunLoop* runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)setTopBtnState:(PGFocusButtonState)topBtnState{
    _topBtnState = topBtnState;
    [self setPg_state:topBtnState button:self.topBtn];
}

- (void)setBottomBtnState:(PGFocusButtonState)bottomBtnState{
    _bottomBtnState = bottomBtnState;
    [self setPg_state:bottomBtnState button:self.bottomBtn];
}

- (void)setPg_state:(PGFocusButtonState)pg_state button:(WKInterfaceButton*)button{
    [button setHidden:NO];
    switch (pg_state) {
        case PGFocusButtonStateHidden:
            [button setHidden:YES];
            break;
        case PGFocusButtonStateStartFocus:
            [button setTitle:@"开始专注"];
            break;
        case PGFocusButtonStateObsolete:
            [button setTitle:@"作废"];
            break;
        case PGFocusButtonStateNext:
            [button setTitle:@"下一个番茄"];
            break;
        case PGFocusButtonStateStartRest:
            [button setTitle:@"开始休息"];
            break;
        case PGFocusButtonStateStopRest:
            [button setTitle:@"停止休息"];
            break;
        default:
            break;
    }
}


- (void)topBtnClick {
    [self hanlderButtonClick:self.topBtnState];
}

- (void)bottomBtnClick {
    [self hanlderButtonClick:self.bottomBtnState];
}

- (void)hanlderButtonClick:(PGFocusButtonState)state{
    switch (state) {
        case PGFocusButtonStateStartFocus://开始专注
            self.currentFocusState = PGFocusStateFocusing;
            return;
        case PGFocusButtonStateObsolete://作废
        {
            [self timerInvalidate];
            self.currentFocusState = PGFocusStateWillFocus;
        }
            return;
        case PGFocusButtonStateNext://下一个番茄
            self.currentFocusState = PGFocusStateFocusing;
            return;
        case PGFocusButtonStateStartRest://开始休息
            self.currentFocusState = PGFocusStateShortBreaking;
            return;
        case PGFocusButtonStateStopRest://停止休息
            self.currentFocusState = PGFocusStateFocusing;
            return;
        default:
            DLog(@"无匹配");
            break;
    }
}

//手机震动
//- (void)vibrating{
//    if (WKConfigMgr.VibratingAlert) {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    }
//}

//本地通知
//- (void)localNotiWithTimeIntervalSinceNow:(NSTimeInterval)seconds alertBody:(NSString*)alertBody{
//    if(!WKConfigMgr.NotifyAlert){
//        return;
//    }
//    //1.创建本地通知对象
//    UILocalNotification* ln = [UILocalNotification new];
//
//    //2.设置属性
//    //2.1 设置通知弹出时间
//    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
//    //2.2 设置通知内容
//    ln.alertBody = alertBody;
//    //2.3 设置图标右上角的角标通知信息数量
//    ln.applicationIconBadgeNumber = 1;
//
//    //4.调度通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
//}


@end
