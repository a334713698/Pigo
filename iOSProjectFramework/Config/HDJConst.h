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
typedef void (^CommonBlcok) (void);                               

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

//PGRecycleBinTaskCell
UIKIT_EXTERN const CGFloat PGRecycleBinTaskCellHeight;

//PGTaskListAddCollectionViewCell
UIKIT_EXTERN const CGFloat PGTaskListAddCollectionViewTitleHeight;
UIKIT_EXTERN const CGFloat PGTaskListAddCollectionViewCellSize;
UIKIT_EXTERN const CGFloat PGTaskListAddCollectionViewCellItemSpacing;
UIKIT_EXTERN const CGFloat PGTaskListAddCollectionViewCellLineSpacing;

//PGConfigManager
UIKIT_EXTERN NSString *const PGConfigParas;
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

//PGShortcutType
UIKIT_EXTERN NSString *const PGShortcutTypeList;
UIKIT_EXTERN NSString *const PGShortcutTypeSetting;

//PGSettingCell
UIKIT_EXTERN const CGFloat PGSettingCellContentHeight;
UIKIT_EXTERN const CGFloat PGSettingCellMoreHeight;
UIKIT_EXTERN const CGFloat PGSettingCellAccessoryWidth;
UIKIT_EXTERN const CGFloat PGSettingCellAccessoryHeight;

//PGStatistics
UIKIT_EXTERN const CGFloat PGStatisticsTodayDataCellHeight;
UIKIT_EXTERN const CGFloat PGStatisticsTodayPeriodCellHeight;
UIKIT_EXTERN const CGFloat PGStatisticsAnnualActivityDuration;
UIKIT_EXTERN const CGFloat PGStatisticsChartCellHeight;

//PGTotalStatisticsViewController
UIKIT_EXTERN const CGFloat PGTotalStatisticsChartCellHeight;
UIKIT_EXTERN const CGFloat PGTotalStatisticsTaskItemCellHeight;


//PGLocalNotiTool
UIKIT_EXTERN NSString *const PGLocalNotiCateIDCompleteTomato;
UIKIT_EXTERN NSString *const PGLocalNotiCateIDCompleteRest;
UIKIT_EXTERN NSString *const PGLocalNotiActionIDStart;
UIKIT_EXTERN NSString *const PGLocalNotiActionIDNext;
UIKIT_EXTERN NSString *const PGLocalNotiActionIDRest;


#endif /* PGConst_h */
