//
//  PGWatchEnum.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#ifndef PGWatchEnum_h
#define PGWatchEnum_h

//传输数据的类型
typedef enum : NSInteger {
    PGTransmittedtTypeTaskList = 1,     //番茄列表
    PGTransmittedtTypeSettingConfig     //设置参数
} PGTransmittedtType;


typedef enum : NSUInteger {
    PGFocusStateWillFocus,//准备专注
    PGFocusStateFocusing,//专注中
    PGFocusStateWillShortBreak,//准备短时休息
    PGFocusStateShortBreaking,//短时休息中
    PGFocusStateWillLongBreak,//准备长时休息
    PGFocusStateLongBreaking,//长时休息中
} PGFocusState;

typedef enum : NSUInteger {
    PGFocusButtonStateHidden,//隐藏
    PGFocusButtonStateStartFocus,//开始专注
    PGFocusButtonStateObsolete,//作废
    PGFocusButtonStateNext,//下一个番茄
    PGFocusButtonStateStartRest,//开始休息
    PGFocusButtonStateStopRest,//停止休息
} PGFocusButtonState;

#endif /* PGWatchEnum_h */
