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
#import "DJDatabaseMgr.h"

@interface InterfaceController ()

@property (nonatomic, strong) DJDatabaseMgr* dbMgr;

@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *dataArr;
@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *taskList;
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
        NSArray* arr = [USER_DEFAULT valueForKey:TASK_LIST];
        if (arr.count) {
            _dataArr = [PGTaskListModel mj_objectArrayWithKeyValuesArray:arr].mutableCopy;
        }else{
            _dataArr = [NSMutableArray array];
        }
        
        
    }
    return _dataArr;
}

- (NSMutableArray<PGTaskListModel*> *)taskList{
    if (!_taskList) {
        _taskList = [NSMutableArray array];
        [self.dbMgr.database open];
        NSArray* taskArr = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"0"] withSortedMode:NSOrderedAscending andColumnName:@"priority"];
        if (taskArr.count) {
            NSString* dateToday = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
            NSArray* recordDicArr = [self.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateToday)]];
            NSMutableArray* recordModelArr = [PGTomatoRecordModel mj_objectArrayWithKeyValuesArray:recordDicArr];
            if (recordDicArr.count) {
                for (NSDictionary* taskDic in taskArr) {
                    PGTaskListModel *model = [[PGTaskListModel alloc] mj_setKeyValues:taskDic];
                    for (PGTomatoRecordModel* recordModel in recordModelArr) {
                        if (model.task_id == recordModel.task_id) {
                            model.count = recordModel.count;
                            [recordModelArr removeObject:recordModel];
                            break;
                        }
                    }
                    [_taskList addObject:model];
                }
            }else{
                [_taskList addObjectsFromArray:[PGTaskListModel mj_objectArrayWithKeyValuesArray:taskArr]];
            }
//            [self saveListData];
//            [self.viewModel watch_updateTaskList:_taskList.copy];
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
}


- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    [super table:table didSelectRowAtIndex:rowIndex];
    PGTaskListModel* model = self.dataArr[rowIndex];

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
    self.dataArr = self.taskList;
    [self.table setNumberOfRows:self.dataArr.count withRowType:@"taskCell"];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        PGTaskListModel* model = self.dataArr[i];
        PGTaskListCell* cell = [self.table rowControllerAtIndex:i];
        [cell.itemLabel setText:model.task_name];
        [cell.countLabel setText:QMStringFromNSInteger(model.count)];
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



