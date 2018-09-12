//
//  PGSettingViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingViewModel.h"

const NSInteger PGSettingAllEventTypes = (PGSettingEventTypeClick | PGSettingEventTypeDetail | PGSettingEventTypeSwicher);

@implementation PGSettingViewModel

+ (NSArray*)gettingCellData{
//    PGSettingEventTypeClick,
//    PGSettingEventTypeDetail,
//    PGSettingEventTypeSwicher

    
//    PGSettingContentTypeStatistics,         //统计
//    PGSettingContentTypeVibratingAlert,     //震动提示
//    PGSettingContentTypeTomatoLength,       //番茄时长
//    PGSettingContentTypeShortBreak,         //短时休息
//    PGSettingContentTypeLongBreak,          //长时休息
//    PGSettingContentTypeLongBreakInterval,  //长时休息间隔
//    PGSettingContentTypeAutomaticNext,      //自动下一个
//    PGSettingContentTypeAutomaticRest,      //自动休息
//    PGSettingContentTypeScreenBright,       //屏幕亮
//    PGSettingContentTypeDataSync            //数据同步

    return @[
             @{@"sectionTitle":@"",@"data":@[
                       @{@"title":@"统计",@"eventType":@(PGSettingEventTypeClick),@"contentType":@(PGSettingContentTypeStatistics)}
             ]},
            
             @{@"sectionTitle":@"专注设置",@"data":@[
                       @{@"title":@"震动提示",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeVibratingAlert)},
                       @{@"title":@"番茄时长",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeTomatoLength)},
                       @{@"title":@"短时休息",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeShortBreak)},
                       @{@"title":@"长时休息",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeLongBreak)},
                       @{@"title":@"长时休息间隔",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeLongBreakInterval)},
                       @{@"title":@"自定进入下个番茄",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeAutomaticNext)},
                       @{@"title":@"自定进入休息时间",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeAutomaticRest)},
                       @{@"title":@"屏幕常亮",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeScreenBright)},
             ]},

             @{@"sectionTitle":@"数据同步",@"data":@[
                       @{@"title":@"最近同步时间",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeDataSync)}
                       ]},
             ];
}

@end
