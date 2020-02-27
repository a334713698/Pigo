//
//  PGWatchTransTool.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGWatchTransTool.h"

@implementation PGWatchTransTool

SYNTHESIZE_SINGLETON_FOR_CLASS(PGWatchTransTool)

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
+ (BOOL)canSendMsgToWatch{
    
    if (![WCSession isSupported]) {
        DLog(@"当前系统版本不支持 Connectivity框架");
        return false;
    }else if (!WatchTransToolInstance.sessionDefault.isWatchAppInstalled){
        DLog(@"watch 未安装此App");
        return false;
    }else if (!WatchTransToolInstance.sessionDefault.isReachable){
        DLog(@"watch 当前不在激活状态");
        return false;
    }else{
        return true;
    }
}

//发送前台字典数据
//发送前台字典数据
+ (void)sendMessageObj:(id)messageObj type:(PGTransmittedtType)type replyHandler:(nullable void (^)(NSDictionary<NSString *, id> *replyMessage))replyHandler errorHandler:(nullable void (^)(NSError *error))errorHandler{
    
    [WatchTransToolInstance.sessionDefault sendMessage:@{@"data":[messageObj mj_JSONString],@"type":@(type)} replyHandler:replyHandler errorHandler:errorHandler];
}


//发送队列式字典传输
- (void)sendBGMsgDic{
    [self.sessionDefault transferUserInfo:self.messageDic];
}


#pragma mark - WCSessionDelegate
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message{
    DLog(@"%s",__func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
//        [MFHUDManager showSuccess:@"didReceiveMessage 哦哈哈"];
    });
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void (^)(NSData * _Nonnull))replyHandler{
    DLog(@"收到来自watch的信息");
    dispatch_sync(dispatch_get_main_queue(), ^{
//        [MFHUDManager showSuccess:@"收到来自watch的信息"];
    });
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    DLog(@"--------------------");
    DLog(@"activationDidCompleteWithState：%ld",activationState)
}


- (void)sessionDidBecomeInactive:(nonnull WCSession *)session {
    DLog(@"--------------------");
    DLog(@"sessionDidBecomeInactive");
}


- (void)sessionDidDeactivate:(nonnull WCSession *)session {
    DLog(@"--------------------");
    DLog(@"sessionDidDeactivate");
}


@end
