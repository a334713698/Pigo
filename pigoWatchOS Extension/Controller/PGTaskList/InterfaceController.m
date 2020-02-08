//
//  InterfaceController.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/14.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "InterfaceController.h"
#import "PGTaskListCell.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "PGTaskListModel.h"
#import "PGFocusInterfaceController.h"

@interface InterfaceController ()

@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *dataArr;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@end


@implementation InterfaceController

- (NSMutableArray <PGTaskListModel*>*)dataArr{
    if (!_dataArr) {
        NSArray* arr = [USER_DEFAULT valueForKey:TASK_LIST];
        if (arr.count) {
            _dataArr = [PGTaskListModel mj_objectArrayWithKeyValuesArray:arr].mutableCopy;
        }else{
            _dataArr = [NSMutableArray array];
        }
    }
    return _dataArr;
}

- (void)awakeWithContext:(id)context {
    // Configure interface objects here.
    [super awakeWithContext:context];
    NSLog(@"awakeWithContext");
//    [self addMenuItemWithItemIcon:WKMenuItemIconAdd title:@"添加" action:@selector(addTask)];
    [self addMenuItemWithItemIcon:WKMenuItemIconResume title:NSLocalizedString(@"Refresh", nil) action:@selector(refreshTaskList)];
    [self reloadData];
    
    [NOTI_CENTER addObserver:self selector:@selector(refreshTaskList) name:TaskLiskUpdateNotification object:nil];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate");
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    [super table:table didSelectRowAtIndex:rowIndex];
    PGTaskListModel* model = self.dataArr[rowIndex];
    [self presentControllerWithName:@"PGFocusInterfaceController" context:model];
}

//- (void)addTask{
//    NSLog(@"添加新任务");
//
//    WS(weakSelf)
//    [self presentTextInputControllerWithSuggestions:@[@"工作",@"学习"] allowedInputMode:WKTextInputModePlain completion:^(NSArray * _Nullable results) {
//        DLog(@"%@",results);
//        PGTaskListModel* model = [PGTaskListModel new];
//        model.task_name = results.firstObject;
//        [weakSelf.dataArr insertObject:model atIndex:0];
//        [weakSelf reloadData];
//        
//        //告诉手机，我添加了新的任务，并同步数据
//    }];
//    
//}

- (void)refreshTaskList{
    _dataArr = nil;
    [self reloadData];
}

- (void)reloadData{
    [self.table setNumberOfRows:self.dataArr.count withRowType:@"taskCell"];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        PGTaskListModel* model = self.dataArr[i];
        PGTaskListCell* cell = [self.table rowControllerAtIndex:i];
        [cell.itemLabel setText:model.task_name];
        [cell.countLabel setText:@"0"];
    }
}

#pragma mark - send msg to iphone
- (void)sendMsgToiPhone{
    
    if ([WKWatchTransTool canSendMsgToiPhone]) {
        //发送前台字典数据
        [WKWatchTransToolInstance.sessionDefault sendMessageData:[PGTool dicToData:WKWatchTransToolInstance.messageDic] replyHandler:^(NSData * _Nonnull replyMessageData) {
            NSLog(@"发送成功");
        } errorHandler:^(NSError * _Nonnull error) {
            NSLog(@"发送失败");
        }];
    }
}

@end



