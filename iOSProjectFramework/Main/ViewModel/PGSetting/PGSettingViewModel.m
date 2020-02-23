//
//  PGSettingViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingViewModel.h"
#import "iCloudHandle.h"
#import "PGDataSyncModel.h"

@interface PGSettingViewModel ()

@property (nonatomic ,strong) NSMetadataQuery   *myMetadataQuery;

@end

@implementation PGSettingViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpNotification];
    }
    return self;
}

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
//    PGSettingContentTypeDataBackup,         //数据备份
//    PGSettingContentTypeDataRecover,        //数据恢复

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
                       @{@"title":NSLocalizedString(@"Pigo Recycle Bin", nil),@"eventType":@(PGSettingEventTypeClick),@"contentType":@(PGSettingContentTypeRecycleBin)}
                    ]},
             @{@"sectionTitle":NSLocalizedString(@"Sync", nil),@"data":@[
                        @{@"title":NSLocalizedString(@"BackupiCloud", nil),@"eventType":@(PGSettingEventTypeClick),@"contentType":@(PGSettingContentTypeDataBackup)},
                        @{@"title":NSLocalizedString(@"RecoveriCloud", nil),@"eventType":@(PGSettingEventTypeClick),@"contentType":@(PGSettingContentTypeDataRecover)}
                         ]},

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
        [PGWatchTransTool sendMessageObj:config type:PGTransmittedtTypeSettingConfig replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            DLog(@"replyMessage：%@",replyMessage[@"reply"]);
        } errorHandler:^(NSError * _Nonnull error) {
            DLog(@"%@",error.userInfo);
        }];
    }
}


//数据序列化
+ (void)dataSerialize{
    DJDatabaseManager* dataMgr = [DJDatabaseManager sharedDJDatabaseManager];
    [dataMgr.database open];
    NSArray* tables = dataMgr.tables;
    NSMutableDictionary* dms = [NSMutableDictionary dictionaryWithCapacity:tables.count];
    for (NSString* tb in tables) {
        NSArray* arr = [dataMgr getAllTuplesFromTabel:tb];
        [dms setValue:arr forKey:tb];
    }
    DLog(@"%@",dms);
    [dataMgr.database close];
    NSString *fileName = [NSString stringWithFormat:@"pigo_%@",[NSDate dateToCustomFormateString:@"yyyyMMddHHmmss" andDate:[NSDate new]]];
    PGDataSyncModel* dsModel = [PGDataSyncModel new];
    dsModel.fileName = fileName;
    dsModel.tables = dms;
    dsModel.config = [PGConfigMgr mj_JSONObject];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[dsModel mj_JSONObject] options:0 error:NULL];
    [iCloudHandle createDocumentWithFileName:fileName content:jsonData handler:^{
        [MFHUDManager showSuccess:NSLocalizedString(@"BackupSuccess", nil)];
    }];
}

- (NSMetadataQuery *)myMetadataQuery{
    if (!_myMetadataQuery) {
        _myMetadataQuery = [[NSMetadataQuery alloc] init];
    }
    return _myMetadataQuery;
}

- (void)deserializationCompelete:(CommonBlcok)recoverHandler{
    self.recoverHandler = recoverHandler;
    [iCloudHandle getNewDocument:self.myMetadataQuery];
}

- (void)setUpNotification{
    //开始更新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentDidStartGather:) name:NSMetadataQueryDidStartGatheringNotification object:self.myMetadataQuery];

    //数据更新进度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentGatherProgress:) name:NSMetadataQueryGatheringProgressNotification object:self.myMetadataQuery];

    //获取最新数据完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentDidFinishedGather:) name:NSMetadataQueryDidFinishGatheringNotification object:self.myMetadataQuery];
    
    //数据已更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentDidUpdate:) name:NSMetadataQueryDidUpdateNotification object:self.myMetadataQuery];

}

#pragma mark - NSNotificationCenter
- (void)documentDidStartGather:(NSMetadataQuery *)metadataQuery{
    DLog(@"Document 开始获取");
}

- (void)documentGatherProgress:(NSMetadataQuery *)metadataQuery{
    DLog(@"Document 获取进度");
}

- (void)documentDidFinishedGather:(NSMetadataQuery *)metadataQuery{
    DLog(@"Document 数据获取成功");
    
    NSArray *items =self.myMetadataQuery.results;
    __block int completionCount = 0;
    NSMutableArray* results = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMetadataItem *item = obj;
        
        //获取文件名
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        //获取文件创建日期
        NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        
        NSLog(@"%@,%@",fileName,date);
        
        ZZRDocument *doc = [[ZZRDocument alloc] initWithFileURL:[iCloudHandle getUbiquityContauneURLWithFileName:fileName]];
        [doc openWithCompletionHandler:^(BOOL success) {
            //读取操作是在后台进行的
            if(success){
                completionCount++;
                NSString *jsonConten = [[NSString alloc] initWithData:doc.myData encoding:NSUTF8StringEncoding];
                PGDataSyncModel* dsModel = [[PGDataSyncModel alloc] mj_setKeyValues:[jsonConten mj_keyValues]];
                [results addObject:dsModel];
//                DLog(@"第%d：%@",completionCount,dsModel.fileName);
                if (completionCount == items.count) {
                    DLog(@"全部获取");
                    NSArray<PGDataSyncModel*>* sortedArr = [results sortedArrayUsingComparator:^NSComparisonResult(PGDataSyncModel* obj1, PGDataSyncModel* obj2) {
                        return [obj1.fileName compare:obj2.fileName];
                    }];
                    DLog(@"useful：%@",sortedArr.lastObject.fileName);
                    [self dataRecover:sortedArr.lastObject];
                }
            }
        }];
    }];
}


- (void)documentDidUpdate:(NSMetadataQuery *)metadataQuery{
    DLog(@"Document 数据更新");
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dataRecover:(PGDataSyncModel*)dsModel{
    [PGConfigMgr setValuesForKeysWithDictionary:dsModel.config];
    if (self.recoverHandler) {
        self.recoverHandler();
    }
    
    DJDatabaseManager* dgMgr = [DJDatabaseManager sharedDJDatabaseManager];
    [dgMgr.database open];
    
    [dgMgr.database beginTransaction];//开启一个事务
    BOOL isRollBack = NO;
    @try {
        for(NSString * table in dsModel.tables.allKeys){
            [dgMgr deleteAllDataFromTabel:table];
            NSArray* items = dsModel.tables[table];
            for (NSDictionary* item in items) {
                NSMutableDictionary* tempDic = item.mutableCopy;
                for (NSString* keyStr in item.allKeys) {
                    id value = item[keyStr];
                    if ([value isKindOfClass:[NSString class]]) {
                        tempDic[keyStr] = [NSString stringWithFormat:@"\'%@\'",value];
                    }
                    if ([value isKindOfClass:[NSNull class]]) {
                        [tempDic removeObjectForKey:keyStr];
                    }
                }
                [dgMgr insertDataIntoTableWithName:table andKeyValues:tempDic.copy];
            }
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [dgMgr.database rollback];//回滚事务
    } @finally {
        if(!isRollBack){
            [dgMgr.database commit];//重新提交事务
        }
    }
    [dgMgr.database close];
}

@end
