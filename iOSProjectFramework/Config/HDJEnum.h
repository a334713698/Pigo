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
    PGFocusStateStart,
    PGFocusStateStop
} PGFocusState;

#endif /* HDJEnum_h */
