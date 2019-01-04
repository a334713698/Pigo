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

- (void)saveListData:(NSArray<PGTaskListModel*>*)taskModels{
    NSMutableArray* kvArr = [NSMutableArray array];
    for (PGTaskListModel *model in taskModels) {
        [kvArr addObject:[model mj_keyValues]];
    }
    NSUserDefaults *sharedUD = [[NSUserDefaults alloc] initWithSuiteName:@"group.hdj.pigo"];
    [sharedUD setValue:[kvArr mj_JSONData] forKey:TaskListData];
    [sharedUD synchronize];
}


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
