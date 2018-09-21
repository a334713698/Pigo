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
    if ([PGWatchTransTool canSendMsgToWatch]){
        [PGWatchTransTool sendMessageObj:arr type:PGTransmittedtTypeTaskList replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            DLog(@"replyMessage：%@",replyMessage[@"reply"]);
        } errorHandler:^(NSError * _Nonnull error) {
            DLog(@"%@",error.userInfo);
        }];
    }
}

@end
