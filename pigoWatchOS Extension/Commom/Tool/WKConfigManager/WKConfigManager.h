//
//  WKConfigManager.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define WKConfigMgr [WKConfigManager sharedWKConfigManager]

@interface WKConfigManager : NSObject

PROPERTY_SINGLETON_FOR_CLASS(WKConfigManager)

@property (nonatomic, assign) BOOL NotifyAlert;               //通知提示
@property (nonatomic, assign) BOOL VibratingAlert;            //震动提示
@property (nonatomic, assign) NSInteger TomatoLength;              //番茄时长
@property (nonatomic, assign) NSInteger ShortBreak;                //短时休息
@property (nonatomic, assign) NSInteger LongBreak;                 //长时休息
@property (nonatomic, assign) NSInteger LongBreakInterval;         //长时休息间隔
@property (nonatomic, assign) BOOL AutomaticNext;             //自动下一个
@property (nonatomic, assign) BOOL AutomaticRest;             //自动休息
@property (nonatomic, assign) BOOL ScreenBright;              //屏幕亮
@property (nonatomic, strong) NSDate *DataSync;              //数据同步时间

- (void)setup;
@end

NS_ASSUME_NONNULL_END
