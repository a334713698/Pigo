//
//  HDJEnum.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#ifndef HDJEnum_h
#define HDJEnum_h

/** 统一管理枚举 */

typedef NS_ENUM(NSInteger, NSNetRequestState) {
    NetRequestSuccess = 0,//网络请求成功

};

typedef enum : NSUInteger {
    QMLeftNavButtonStateNormal,
    QMLeftNavButtonStateWhite,
    QMLeftNavButtonStateCustom,
    QMLeftNavButtonStateHidden
} QMLeftNavButtonState;

typedef enum : NSUInteger {
    QMNavTintColorMainColor,//默认，主色
    QMNavTintColorWhiteColor//白色
} QMNavTintColor;

typedef enum : NSUInteger {
    PGFocusButtonStateHidden,//隐藏
    PGFocusButtonStateStartFocus,//开始专注
    PGFocusButtonStateObsolete,//作废
    PGFocusButtonStateNext,//下一个番茄
    PGFocusButtonStateStartRest,//开始休息
    PGFocusButtonStateStopRest,//停止休息
} PGFocusButtonState;

typedef enum : NSInteger {
    PGSettingEventTypeClick    = 1 <<  0,
    PGSettingEventTypeDetail   = 1 <<  1,
    PGSettingEventTypeSwicher  = 1 <<  2
} PGSettingEventType;


typedef enum : NSInteger {
    PGSettingContentTypeStatistics,         //统计
    PGSettingContentTypeVibratingAlert,     //震动提示
    PGSettingContentTypeNotifyAlert,        //通知提示
    PGSettingContentTypeTomatoLength,       //番茄时长
    PGSettingContentTypeShortBreak,         //短时休息
    PGSettingContentTypeLongBreak,          //长时休息
    PGSettingContentTypeLongBreakInterval,  //长时休息间隔
    PGSettingContentTypeAutomaticNext,      //自动下一个
    PGSettingContentTypeAutomaticRest,      //自动休息
    PGSettingContentTypeScreenBright,       //屏幕亮
    PGSettingContentTypeDataSync            //数据同步
} PGSettingContentType;





//传输数据的类型
typedef enum : NSInteger {
    PGTransmittedtTypeTaskList = 1,     //番茄列表
    PGTransmittedtTypeSettingConfig     //设置参数
} PGTransmittedtType;

#endif /* HDJEnum_h */
