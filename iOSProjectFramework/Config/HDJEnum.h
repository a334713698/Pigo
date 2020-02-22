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
    PGFocusButtonStateObsolete,//中止
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
    PGSettingContentTypeStatistics = 1,         //统计
    PGSettingContentTypeRecycleBin,         //番茄回收站
    PGSettingContentTypeVibratingAlert,     //震动提示
    PGSettingContentTypeNotifyAlert,        //通知提示
    PGSettingContentTypeTomatoLength,       //番茄时长
    PGSettingContentTypeShortBreak,         //短时休息
    PGSettingContentTypeLongBreak,          //长时休息
    PGSettingContentTypeLongBreakInterval,  //长时休息间隔
    PGSettingContentTypeAutomaticNext,      //自动下一个
    PGSettingContentTypeAutomaticRest,      //自动休息
    PGSettingContentTypeScreenBright,       //屏幕亮
    PGSettingContentTypeDataSync,            //数据同步
    PGSettingContentTypeDataBackup,            //数据备份
    PGSettingContentTypeDataRecover,            //数据恢复
} PGSettingContentType;

typedef enum : NSUInteger {
    PGStatisticsPeriodTypeWeek,
    PGStatisticsPeriodTypeMonth,
    PGStatisticsPeriodTypeYear
} PGStatisticsPeriodType;

typedef enum : NSInteger {
    PGFocusStateWillFocus,//准备专注
    PGFocusStateFocusing,//专注中
    PGFocusStateWillShortBreak,//准备短时休息
    PGFocusStateShortBreaking,//短时休息中
    PGFocusStateWillLongBreak,//准备长时休息
    PGFocusStateLongBreaking,//长时休息中
} PGFocusState;

typedef enum : NSUInteger {
    PGStatisticsChartDataTypeCount,//完成次数
    PGStatisticsChartDataTypeLength//专注时长
} PGStatisticsChartDataType;

//传输数据的类型
typedef enum : NSInteger {
    PGTransmittedtTypeTaskList = 1,     //番茄列表
    PGTransmittedtTypeSettingConfig     //设置参数
} PGTransmittedtType;

#endif /* HDJEnum_h */
