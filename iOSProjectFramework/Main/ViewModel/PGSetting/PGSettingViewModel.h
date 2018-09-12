//
//  PGSettingViewModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"

UIKIT_EXTERN const NSInteger PGSettingAllEventTypes;

typedef enum : NSInteger {
    PGSettingEventTypeClick    = 1 <<  0,
    PGSettingEventTypeDetail   = 1 <<  1,
    PGSettingEventTypeSwicher  = 1 <<  2
} PGSettingEventType;


typedef enum : NSInteger {
    PGSettingContentTypeStatistics,         //统计
    PGSettingContentTypeVibratingAlert,     //震动提示
    PGSettingContentTypeTomatoLength,       //番茄时长
    PGSettingContentTypeShortBreak,         //短时休息
    PGSettingContentTypeLongBreak,          //长时休息
    PGSettingContentTypeLongBreakInterval,  //长时休息间隔
    PGSettingContentTypeAutomaticNext,      //自动下一个
    PGSettingContentTypeAutomaticRest,      //自动休息
    PGSettingContentTypeScreenBright,       //屏幕亮
    PGSettingContentTypeDataSync            //数据同步
} PGSettingContentType;

@interface PGSettingViewModel : BaseViewModel

+ (NSArray*)gettingCellData;

@end
