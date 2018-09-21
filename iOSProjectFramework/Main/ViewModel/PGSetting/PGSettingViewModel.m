//
//  PGSettingViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingViewModel.h"

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
                       @{@"title":@"震动提示",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeVibratingAlert),@"detail":@(PGConfigMgr.VibratingAlert),@"paraName":PGConfigParaVibratingAlert},
                       @{@"title":@"通知提示",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeNotifyAlert),@"detail":@(PGConfigMgr.NotifyAlert),@"paraName":PGConfigParaNotifyAlert},
                       @{@"title":@"番茄时长",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeTomatoLength),@"detail":@(PGConfigMgr.TomatoLength),@"unit":@"分钟",@"paraName":PGConfigParaTomatoLength},
                       @{@"title":@"短时休息",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeShortBreak),@"detail":@(PGConfigMgr.ShortBreak),@"unit":@"分钟",@"paraName":PGConfigParaShortBreak},
                       @{@"title":@"长时休息",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeLongBreak),@"detail":@(PGConfigMgr.LongBreak),@"unit":@"分钟",@"paraName":PGConfigParaLongBreak},
                       @{@"title":@"长时休息间隔",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeLongBreakInterval),@"detail":@(PGConfigMgr.LongBreakInterval),@"unit":@"个番茄",@"paraName":PGConfigParaLongBreakInterval},
                       @{@"title":@"自动进入下个番茄",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeAutomaticNext),@"detail":@(PGConfigMgr.AutomaticNext),@"paraName":PGConfigParaAutomaticNext},
                       @{@"title":@"自动进入休息时间",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeAutomaticRest),@"detail":@(PGConfigMgr.AutomaticRest),@"paraName":PGConfigParaAutomaticRest},
                       @{@"title":@"屏幕常亮",@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeScreenBright),@"detail":@(PGConfigMgr.ScreenBright),@"paraName":PGConfigParaScreenBright},
             ]},

             @{@"sectionTitle":@"数据同步",@"data":@[
                       @{@"title":@"最近同步时间",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeDataSync),@"detail":@"未同步",@"paraName":@""}
                       ]}
             ];
}

+ (void)watch_updateSettingConfig{
    if ([PGWatchTransTool canSendMsgToWatch]){
        NSMutableDictionary* config = [PGConfigMgr mj_keyValues].mutableCopy;
        [config removeObjectForKey:@"DataSync"];
        [PGWatchTransTool sendMessageObj:config type:PGTransmittedtTypeSettingConfig replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            DLog(@"replyMessage：%@",replyMessage[@"reply"]);
        } errorHandler:^(NSError * _Nonnull error) {
            DLog(@"%@",error.userInfo);
        }];
    }
}

@end
