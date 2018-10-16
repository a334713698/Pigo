//
//  PGUserModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGUserModel.h"

@implementation PGUserModel

SYNTHESIZE_SINGLETON_FOR_CLASS(PGUserModel)

- (DJDatabaseManager *)dbMgr{
    if (!_dbMgr) {
        _dbMgr = [DJDatabaseManager sharedDJDatabaseManager];
    }
    return _dbMgr;
}

- (void)setup{
    [self.dbMgr.database open];
    NSDictionary* dic = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_default" andSymbol:@"=" andSpecificValue:@"1"]].firstObject;
    PGTaskListModel* model = [[PGTaskListModel alloc] mj_setKeyValues:dic];
    
    NSString* dateToday = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
    NSDictionary* tuple = [self.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(model.task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateToday)]]].firstObject;
    NSInteger count = [tuple[@"count"] integerValue];
    model.count = count;
    
    [self.dbMgr.database close];
    self.currentTask = model;
}

- (void)completeATomato{
    DLog(@"完成一个番茄");
    if (!self.currentTask.task_id) {
        return;
    }
    [self.dbMgr.database open];
    NSString* dateToday = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
    
    NSDictionary* tuple = [self.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(self.currentTask.task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateToday)]]].firstObject;
    
    if (tuple) {
        NSInteger count = [tuple[@"count"] integerValue];
        [self.dbMgr updateDataIntoTableWithName:tomato_record_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(self.currentTask.task_id)] andNewModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"count" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(count+1)]];
    }else{
        NSMutableDictionary* mutableDic = [NSMutableDictionary dictionaryWithCapacity:5];
        [mutableDic setValue:QMStringFromNSInteger(self.currentTask.task_id) forKey:@"task_id"];
        [mutableDic setValue:[[NSDate new] dateToTimeStamp] forKey:@"add_time"];
        [mutableDic setValue:dateToday forKey:@"add_date"];
        [mutableDic setValue:@1 forKey:@"count"];
        [self.dbMgr insertDataIntoTableWithName:tomato_record_table andKeyValues:mutableDic.copy];
    }
    [self.dbMgr.database close];
}

@end
