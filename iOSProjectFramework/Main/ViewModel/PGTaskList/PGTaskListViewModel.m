//
//  PGTaskListViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTaskListViewModel.h"

@interface PGTaskListViewModel()

@end

@implementation PGTaskListViewModel

- (void)watch_updateTaskList:(NSArray<PGTaskListModel*>*)list{
    NSArray* arr = [PGTaskListModel mj_keyValuesArrayWithObjectArray:list];
    if ([self canSendMsgToWatch]){
        [self.sessionDefault sendMessage:@{@"data":[arr mj_JSONString]} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            DLog(@"replyMessage：%@",replyMessage[@"reply"]);
        } errorHandler:^(NSError * _Nonnull error) {
            DLog(@"%@",error.userInfo);
        }];
    }
}

#pragma mark - Watch
- (BOOL)canSendMsgToWatch{
    
    if (![WCSession isSupported]) {
        DLog(@"当前系统版本不支持 Connectivity框架");
        return false;
    }else if (!self.sessionDefault.isReachable){
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

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message{
    DLog(@"%s",__func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [MBProgressHUD showSuccess:@"didReceiveMessage 哦哈哈"];
    });
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void (^)(NSData * _Nonnull))replyHandler{
    DLog(@"收到来自watch的信息");
    dispatch_sync(dispatch_get_main_queue(), ^{
        [MBProgressHUD showSuccess:@"收到来自watch的信息"];
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
