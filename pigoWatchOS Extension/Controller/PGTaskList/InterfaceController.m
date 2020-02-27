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
#import "PGTomatoRecordModel.h"
#import "PGFocusInterfaceController.h"
#import "PGStaticNotificationController.h"

@interface InterfaceController ()

@property (nonatomic, strong) DJDatabaseMgr* dbMgr;

@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *dataArr;
@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *taskList;//from database

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@end


@implementation InterfaceController
- (DJDatabaseMgr *)dbMgr{
    if (!_dbMgr) {
        _dbMgr = [DJDatabaseMgr sharedDJDatabaseMgr];
    }
    return _dbMgr;
}
- (NSMutableArray <PGTaskListModel*>*)dataArr{
    if (!_dataArr) {
//        NSArray* arr = [USER_DEFAULT valueForKey:TASK_LIST];
//        if (arr.count) {
//            _dataArr = [PGTaskListModel mj_objectArrayWithKeyValuesArray:arr].mutableCopy;
//        }else{
//            _dataArr = [NSMutableArray array];
//        }
        self.dataArr = self.taskList;
    }
    return _dataArr;
}

- (NSMutableArray<PGTaskListModel*> *)taskList{
    if (!_taskList) {
        _taskList = [NSMutableArray array];
        [self.dbMgr.database open];
        NSArray* taskArr = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"0"] withSortedMode:NSOrderedAscending andColumnName:@"priority"];
        if (taskArr.count) {
            [_taskList addObjectsFromArray:[PGTaskListModel mj_objectArrayWithKeyValuesArray:taskArr]];
        }
        [self.dbMgr.database close];
    }
    return _taskList;
}


- (void)awakeWithContext:(id)context {
    // Configure interface objects here.
    [super awakeWithContext:context];
    NSLog(@"awakeWithContext-%@",NSStringFromClass([self class]));

    [self addMenuItemWithItemIcon:WKMenuItemIconResume title:NSLocalizedString(@"Refresh", nil) action:@selector(refreshTaskList)];
    [self reloadData];
    
    
    [NOTI_CENTER addObserver:self selector:@selector(refreshTaskList) name:TaskLiskUpdateNotification object:nil];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate-%@",NSStringFromClass([self class]));
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate-%@",NSStringFromClass([self class]));
    [NOTI_CENTER removeObserver:self];
}

- (void)willDisappear{
    [super willDisappear];
    NSLog(@"willDisappear-%@",NSStringFromClass([self class]));
}


- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    [super table:table didSelectRowAtIndex:rowIndex];
    if (WKUserModelInstance.currentFocusState == PGFocusStateFocusing || WKUserModelInstance.currentFocusState  == PGFocusStateShortBreaking || WKUserModelInstance.currentFocusState == PGFocusStateLongBreaking) {
        return;
    }
    PGTaskListModel* model = self.dataArr[rowIndex];
    [NOTI_CENTER postNotificationName:TaskUpdateNotification object:model];
    [self dismissController];
}

- (void)refreshTaskList{
    _dataArr = nil;
    [self reloadData];
    [self sendMsgToiPhone];
}

- (void)reloadData{
    [self.table setNumberOfRows:self.dataArr.count withRowType:@"taskCell"];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        PGTaskListModel* model = self.dataArr[i];
        PGTaskListCell* cell = [self.table rowControllerAtIndex:i];
        [cell.groupView setBackgroundColor:HexColor(model.bg_color)];
        [cell.itemLabel setText:model.task_name];
//        [cell.countLabel setText:QMStringFromNSInteger(model.count)];
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



