//
//  PGConst.h
//  PGMedical
//
//  Created by 洪冬介 on 2018/3/26.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#ifndef PGConst_h
#define PGConst_h



//block
typedef void (^HDJCompletionHandler)(id resultObject, NSError *error);
typedef void (^DidSelectItemBlock)(NSIndexPath*,id);
typedef void (^PicChooseCallbackBlock)(NSArray<UIImage*>* imageArr,NSArray<NSString*>* urlArr);
typedef void (^DataCallbackBlock)(id result);

// 常量

//Common
UIKIT_EXTERN const CGFloat PGCornerRadius;
UIKIT_EXTERN const CGFloat PGTableViewRowHeight;
UIKIT_EXTERN const CGFloat PGTableViewHeaderSectionHeight;

//PGFocusViewController
UIKIT_EXTERN const CGFloat PGFocusCenterBtnWidth;
UIKIT_EXTERN const CGFloat PGFocusSideBtnWidth;
UIKIT_EXTERN const CGFloat PGFocusBtnHeight;
UIKIT_EXTERN const CGFloat PGFocusBtnBottomLayout;
UIKIT_EXTERN const CGFloat PGFocusBtnCenterXOffset;


//PGTaskCell
UIKIT_EXTERN const CGFloat PGTaskCellHeight;

//PGConfigManager
UIKIT_EXTERN NSString *const PGConfigParas;
UIKIT_EXTERN NSString *const PGConfigParaDataSync;                  //数据同步
UIKIT_EXTERN NSString *const PGConfigParaStatistics;                //统计
UIKIT_EXTERN NSString *const PGConfigParaVibratingAlert;            //震动提示
UIKIT_EXTERN BOOL      const PGConfigParaVibratingAlertDefault;     //震动提示（默认值）
UIKIT_EXTERN NSString *const PGConfigParaNotifyAlert;            //震动提示
UIKIT_EXTERN BOOL      const PGConfigParaNotifyAlertDefault;     //震动提示（默认值）
UIKIT_EXTERN NSString *const PGConfigParaTomatoLength;              //番茄时长
UIKIT_EXTERN NSInteger   const PGConfigParaTomatoLengthDefault;       //番茄时长（默认值）
UIKIT_EXTERN NSString *const PGConfigParaShortBreak;                //短时休息
UIKIT_EXTERN NSInteger   const PGConfigParaShortBreakDefault;         //短时休息（默认值）
UIKIT_EXTERN NSString *const PGConfigParaLongBreak;                 //长时休息
UIKIT_EXTERN NSInteger   const PGConfigParaLongBreakDefault;          //长时休息（默认值）
UIKIT_EXTERN NSString *const PGConfigParaLongBreakInterval;         //长时休息间隔
UIKIT_EXTERN NSInteger   const PGConfigParaLongBreakIntervalDefault;  //长时休息间隔（默认值）
UIKIT_EXTERN NSString *const PGConfigParaAutomaticNext;             //自动下一个
UIKIT_EXTERN BOOL      const PGConfigParaAutomaticNextDefault;      //自动下一个（默认值）
UIKIT_EXTERN NSString *const PGConfigParaAutomaticRest;             //自动休息
UIKIT_EXTERN BOOL      const PGConfigParaAutomaticRestDefault;      //自动休息（默认值）
UIKIT_EXTERN NSString *const PGConfigParaScreenBright;              //屏幕亮
UIKIT_EXTERN BOOL      const PGConfigParaScreenBrightDefault;       //屏幕亮（默认值）


#endif /* PGConst_h */
