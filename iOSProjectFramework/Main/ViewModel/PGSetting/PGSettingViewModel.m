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
                       @{@"title":NSLocalizedString(@"Statistics", nil),@"eventType":@(PGSettingEventTypeClick),@"contentType":@(PGSettingContentTypeStatistics)}
             ]},
            
             @{@"sectionTitle":NSLocalizedString(@"Focus Settings", nil),@"data":@[
                       @{@"title":NSLocalizedString(@"Vibration Alert", nil),@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeVibratingAlert),@"detail":@(PGConfigMgr.VibratingAlert),@"paraName":PGConfigParaVibratingAlert},
                       @{@"title":NSLocalizedString(@"Notification Alert", nil),@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeNotifyAlert),@"detail":@(PGConfigMgr.NotifyAlert),@"paraName":PGConfigParaNotifyAlert},
                       @{@"title":NSLocalizedString(@"Pigo duration", nil),@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeTomatoLength),@"detail":@(PGConfigMgr.TomatoLength),@"unit":NSLocalizedString(@"minutes", nil),@"paraName":PGConfigParaTomatoLength,@"pickArr":[self TomatoLengthDataArr]},
                       @{@"title":NSLocalizedString(@"Short break", nil),@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeShortBreak),@"detail":@(PGConfigMgr.ShortBreak),@"unit":NSLocalizedString(@"minutes", nil),@"paraName":PGConfigParaShortBreak,@"pickArr":[self ShortBreakDataArr]},
                       @{@"title":NSLocalizedString(@"Long break", nil),@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeLongBreak),@"detail":@(PGConfigMgr.LongBreak),@"unit":NSLocalizedString(@"minutes", nil),@"paraName":PGConfigParaLongBreak,@"pickArr":[self LongBreakDataArr]},
                       @{@"title":NSLocalizedString(@"Long break interval", nil),@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeLongBreakInterval),@"detail":@(PGConfigMgr.LongBreakInterval),@"unit":NSLocalizedString(@"Pigos", nil),@"paraName":PGConfigParaLongBreakInterval,@"pickArr":[self LongBreakIntervalDataArr]},
                       @{@"title":NSLocalizedString(@"Long break interval", nil),@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeAutomaticNext),@"detail":@(PGConfigMgr.AutomaticNext),@"paraName":PGConfigParaAutomaticNext},
                       @{@"title":NSLocalizedString(@"Enter break time automatically", nil),@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeAutomaticRest),@"detail":@(PGConfigMgr.AutomaticRest),@"paraName":PGConfigParaAutomaticRest},
                       @{@"title":NSLocalizedString(@"Screen is always on", nil),@"eventType":@(PGSettingEventTypeSwicher),@"contentType":@(PGSettingContentTypeScreenBright),@"detail":@(PGConfigMgr.ScreenBright),@"paraName":PGConfigParaScreenBright},
             ]},

             @{@"sectionTitle":NSLocalizedString(@"Rotten Pigo", nil),@"data":@[
//                       @{@"title":@"最近同步时间",@"eventType":@(PGSettingEventTypeClick | PGSettingEventTypeDetail),@"contentType":@(PGSettingContentTypeDataSync),@"detail":@"未同步",@"paraName":PGConfigParaDataSync}
                       @{@"title":NSLocalizedString(@"Pigo Recycle Bin", nil),@"eventType":@(PGSettingEventTypeClick),@"contentType":@(PGSettingContentTypeRecycleBin)}
                       ]}
             ];
}

//番茄时长
+ (NSArray*)TomatoLengthDataArr{
    NSMutableArray* mutableArr = [NSMutableArray array];
    NSInteger index = 0;
    for (NSInteger i = 5; i <= 120; i+=5) {
        PGSettingDataModel* model = [PGSettingDataModel new];
        model.indexNum = index++;
        model.valueStr = QMStringFromNSInteger(i);
        [mutableArr addObject:model];
    }
    return mutableArr.copy;
}

//短时休息
+ (NSArray*)ShortBreakDataArr{
    NSMutableArray* mutableArr = [NSMutableArray array];
    NSInteger index = 0;
    for (NSInteger i = 1; i <= 30; i++) {
        PGSettingDataModel* model = [PGSettingDataModel new];
        model.indexNum = index++;
        model.valueStr = QMStringFromNSInteger(i);
        [mutableArr addObject:model];
    }
    return mutableArr.copy;
}

//长时休息
+ (NSArray*)LongBreakDataArr{
    NSMutableArray* mutableArr = [NSMutableArray array];
    NSInteger index = 0;
    for (NSInteger i = 10; i <= 60; i++) {
        PGSettingDataModel* model = [PGSettingDataModel new];
        model.indexNum = index++;
        model.valueStr = QMStringFromNSInteger(i);
        [mutableArr addObject:model];
    }
    return mutableArr.copy;
}

//长时休息间隔
+ (NSArray*)LongBreakIntervalDataArr{
    NSMutableArray* mutableArr = [NSMutableArray array];
    NSInteger index = 0;
    for (NSInteger i = 2; i <= 36; i++) {
        PGSettingDataModel* model = [PGSettingDataModel new];
        model.indexNum = index++;
        model.valueStr = QMStringFromNSInteger(i);
        [mutableArr addObject:model];
    }
    return mutableArr.copy;
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
