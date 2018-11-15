//
//  PGConst.m
//  PGMedical
//
//  Created by 洪冬介 on 2018/3/26.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

//Common
const CGFloat PGCornerRadius = 5;
const CGFloat PGTableViewRowHeight = 50;
const CGFloat PGTableViewHeaderSectionHeight = 12;

//PGFocusViewController
const CGFloat PGFocusCenterBtnWidth = 160;
const CGFloat PGFocusSideBtnWidth = 120;
const CGFloat PGFocusBtnHeight = 40;
const CGFloat PGFocusBtnBottomLayout = 150;
const CGFloat PGFocusBtnCenterXOffset = 20;

//PGTaskCell
const CGFloat PGTaskCellHeight = 85;

//PGRecycleBinTaskCell
const CGFloat PGRecycleBinTaskCellHeight = 85;

//PGTaskListAddCollectionViewCell
const CGFloat PGTaskListAddCollectionViewTitleHeight = 40;
const CGFloat PGTaskListAddCollectionViewCellSize = 35;
const CGFloat PGTaskListAddCollectionViewCellItemSpacing = 5;
const CGFloat PGTaskListAddCollectionViewCellLineSpacing = 5;

//PGConfigManager
NSString *const PGConfigParas = @"PGConfigParas";
NSString *const PGConfigParaStatistics = @"PGConfigParaStatistics";                 //统计
NSString *const PGConfigParaDataSync = @"DataSync";                     //数据同步
NSString *const PGConfigParaVibratingAlert = @"VibratingAlert";         //震动提示
BOOL      const PGConfigParaVibratingAlertDefault = NO;                            //震动提示（默认值）
NSString *const PGConfigParaNotifyAlert = @"NotifyAlert";         //通知提示
BOOL      const PGConfigParaNotifyAlertDefault = NO;                            //通知提示（默认值）
NSString *const PGConfigParaTomatoLength = @"TomatoLength";             //番茄时长
NSInteger   const PGConfigParaTomatoLengthDefault = 25;                               //番茄时长（默认值）
NSString *const PGConfigParaShortBreak = @"ShortBreak";                 //短时休息
NSInteger   const PGConfigParaShortBreakDefault = 5.0;                                //短时休息（默认值）
NSString *const PGConfigParaLongBreak = @"LongBreak";                   //长时休息
NSInteger   const PGConfigParaLongBreakDefault = 15.0;                                //长时休息（默认值）
NSString *const PGConfigParaLongBreakInterval = @"LongBreakInterval";   //长时休息间隔
NSInteger   const PGConfigParaLongBreakIntervalDefault = 4.0;                         //长时休息间隔（默认值）
NSString *const PGConfigParaAutomaticNext = @"AutomaticNext";           //自动下一个
BOOL      const PGConfigParaAutomaticNextDefault = NO;                             //自动下一个（默认值）
NSString *const PGConfigParaAutomaticRest = @"AutomaticRest";           //自动休息
BOOL      const PGConfigParaAutomaticRestDefault = NO;                             //自动休息（默认值）
NSString *const PGConfigParaScreenBright = @"ScreenBright";             //屏幕亮
BOOL      const PGConfigParaScreenBrightDefault = NO;                              //屏幕亮（默认值）


//PGShortcutType
NSString *const PGShortcutTypeList = @"PGShortcutTypeList";
NSString *const PGShortcutTypeSetting = @"PGShortcutTypeSetting";

//PGSettingCell
const CGFloat PGSettingCellContentHeight = 40;
const CGFloat PGSettingCellMoreHeight = 150;
const CGFloat PGSettingCellAccessoryWidth = 7;
const CGFloat PGSettingCellAccessoryHeight = 20;

//PGStatistics
const CGFloat PGStatisticsTodayDataCellHeight = 90;
const CGFloat PGStatisticsTodayPeriodCellHeight = 35;
const CGFloat PGStatisticsAnnualActivityDuration = 365;
const CGFloat PGStatisticsChartCellHeight = 200;

//PGTotalStatisticsViewController
const CGFloat PGTotalStatisticsChartCellHeight = 266;
const CGFloat PGTotalStatisticsTaskItemCellHeight = 70;

//PGLocalNotiTool
NSString *const PGLocalNotiCateIDCompleteTomato = @"PGLocalNotiCateIDCompleteTomato";
NSString *const PGLocalNotiCateIDCompleteRest = @"PGLocalNotiCateIDCompleteRest";
NSString *const PGLocalNotiActionIDStart = @"PGLocalNotiActionIDStart";
NSString *const PGLocalNotiActionIDNext = @"PGLocalNotiActionIDNext";
NSString *const PGLocalNotiActionIDRest = @"PGLocalNotiActionIDRest";
