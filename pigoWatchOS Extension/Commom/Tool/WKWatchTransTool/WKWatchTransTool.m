//
//  WKWatchTransTool.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/21.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "WKWatchTransTool.h"

@implementation WKWatchTransTool

SYNTHESIZE_SINGLETON_FOR_CLASS(WKWatchTransTool)

- (WCSession *)sessionDefault{
    if (!_sessionDefault) {
        _sessionDefault = [WCSession defaultSession];
        _sessionDefault.delegate = self;
        [_sessionDefault activateSession];
    }
    return _sessionDefault;
}

- (NSDictionary *)messageDic{
    if (!_messageDic) {
        _messageDic = @{@"message":@"这是一条来自Watch的信息"};
    }
    return _messageDic;
}


#pragma mark - Watch
+ (BOOL)canSendMsgToiPhone{
    if (!WKWatchTransToolInstance.sessionDefault.isReachable){
        DLog(@"Log from watch → watch 当前不在激活状态");
        return false;
    }else{
        return true;
    }
}

//发送前台字典数据
- (void)sendFrontMsgDic{
    [self.sessionDefault sendMessage:self.messageDic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        DLog(@"Log from watch → replyMessage：%@",replyMessage[@"reply"]);
    } errorHandler:^(NSError * _Nonnull error) {
        DLog(@"Log from watch → %@",error);
    }];
}


//发送队列式字典传输
- (void)sendBGMsgDic{
    [self.sessionDefault transferUserInfo:self.messageDic];
}



#pragma mark - WCSessionDelegate
- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error{
    /**
     在会话完成激活后调用。
     如果会话状态为WCSessionActivationStateNotActivated，则会出现错误，并提供更多详细信息。
     */
    switch (activationState) {
        case WCSessionActivationStateActivated:
            DLog(@"Log from watch → watch 被激活");
            break;
        case WCSessionActivationStateInactive:
            DLog(@"Log from watch → watch 不活跃");
            break;
        default:
            DLog(@"Log from watch → watch 未激活");
            break;
    }
}


- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message{
    DLog(@"Log from watch → %s",__func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
        DLog(@"Log from watch → didReceiveMessage");
    });
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    DLog(@"Log from watch → %s",__func__);
    [self handlerWithMessage:message];
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData{
    DLog(@"Log from watch → %s",__func__);
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void (^)(NSData * _Nonnull))replyHandler{
    dispatch_sync(dispatch_get_main_queue(), ^{
        DLog(@"Log from watch → 收到来自iphone的信息");
    });
}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *,id> *)userInfo{
    DLog(@"Log from watch → %s",__func__);
}



#pragma mark - handler
- (void)handlerWithMessage:(NSDictionary*)message{
    PGTransmittedtType type = [message[@"type"] integerValue];
    switch (type) {
        case PGTransmittedtTypeTaskList:
            [self handlerTasklisk:message];
            break;
        case PGTransmittedtTypeSettingConfig:
            [self updateSetting:message];
            break;
        default:
            break;
    }

}

- (void)handlerTasklisk:(NSDictionary*)message{
    NSString* dataStr = message[@"data"];
    NSArray* dataArr = [dataStr mj_JSONObject];
    [USER_DEFAULT setObject:dataArr forKey:TASK_LIST];
    [USER_DEFAULT synchronize];
    [NOTI_CENTER postNotificationName:TaskLiskUpdateNotification object:nil];
    
    DJDatabaseMgr* dgMgr = [DJDatabaseMgr sharedDJDatabaseMgr];
    [dgMgr.database open];
    
    [dgMgr.database beginTransaction];//开启一个事务
    NSDictionary* currentTask;
    BOOL isRollBack = NO;
    @try {
        NSString* table = task_list_table;
        [dgMgr deleteAllDataFromTabel:table];
        NSArray* items = dataArr;
        NSArray* keyArr = @[@"task_id",@"priority",@"is_default",@"add_time",@"bg_color",@"is_delete",@"delete_time",@"task_name",];
        for (NSDictionary* item in items) {
            NSMutableDictionary* tempDic = [NSMutableDictionary dictionary];
            for (NSString* keyStr in keyArr) {
                id value = item[keyStr];
                [tempDic setValue:value forKey:keyStr];
                if ([value isKindOfClass:[NSString class]]) {
                    tempDic[keyStr] = TextFromNSString(value);
                }
                if ([value isKindOfClass:[NSNull class]]) {
                    [tempDic removeObjectForKey:keyStr];
                }else if(QMEqualToString(table, task_list_table) && QMEqualToString(keyStr, @"is_default") && [value boolValue]){
                    currentTask = item;
                }
            }
            [dgMgr insertDataIntoTableWithName:table andKeyValues:tempDic.copy];
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
    
    WKUserModelInstance.currentTask = [[PGTaskListModel alloc] mj_setKeyValues:currentTask];

}

- (void)updateSetting:(NSDictionary*)message{
    NSString* dataStr = message[@"data"];
    NSDictionary* dataDic = [dataStr mj_JSONObject];
    [USER_DEFAULT setObject:dataDic forKey:Config_Setting];
    [USER_DEFAULT synchronize];
    [WKConfigMgr mj_setKeyValues:dataDic];
}


#pragma mark - Method

@end
