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
        _messageDic = @{@"message":@"这是一条来自iPhone的信息"};
    }
    return _messageDic;
}


#pragma mark - Watch
+ (BOOL)canSendMsgToiPhone{
    if (!WKWatchTransToolInstance.sessionDefault.isReachable){
        DLog(@"watch 当前不在激活状态");
        return false;
    }else{
        return true;
    }
}

//发送前台字典数据
- (void)sendFrontMsgDic{
    [self.sessionDefault sendMessage:self.messageDic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        DLog(@"replyMessage：%@",replyMessage[@"reply"]);
    } errorHandler:^(NSError * _Nonnull error) {
        DLog(@"%@",error);
    }];
}


//发送队列式字典传输
- (void)sendBGMsgDic{
    [self.sessionDefault transferUserInfo:self.messageDic];
}



#pragma mark - WCSessionDelegate
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message{
    DLog(@"%s",__func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
        DLog(@"didReceiveMessage");
    });
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    DLog(@"%s",__func__);
    [self handlerWithMessage:message];
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData{
    DLog(@"%s",__func__);
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void (^)(NSData * _Nonnull))replyHandler{
    dispatch_sync(dispatch_get_main_queue(), ^{
        DLog(@"收到来自iphone的信息");
    });
}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *,id> *)userInfo{
    DLog(@"%s",__func__);
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
