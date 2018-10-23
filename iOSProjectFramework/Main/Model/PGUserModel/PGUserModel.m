//
//  PGUserModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGUserModel.h"

@interface PGUserModel ()

@property (nonatomic, copy) NSString *dateNowStr;

@end

@implementation PGUserModel

SYNTHESIZE_SINGLETON_FOR_CLASS(PGUserModel)

- (NSString *)dateNowStr{
    return  _dateNowStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
}

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
    if(model.task_name){
        self.currentTask = model;
    }
}

- (void)completeATomato{
    DLog(@"完成一个番茄");
    if (!self.currentTask.task_id) {
        return;
    }
    [self.dbMgr.database open];
    NSString* dateToday = self.dateNowStr;
    
    NSDictionary* tuple = [self.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(self.currentTask.task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateToday)]]].firstObject;
    
    if (tuple) {
        NSInteger count = [tuple[@"count"] integerValue];
        long length = [tuple[@"length"] longValue];
        NSArray* searchArr = @[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(self.currentTask.task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateToday)]];
        NSArray* conditionArr = @[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"count" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(count+1)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"length" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(length+PGConfigMgr.TomatoLength)]];
        [self.dbMgr updateDataIntoTableWithName:tomato_record_table andSearchModelsArr:searchArr andNewModelsArr:conditionArr];
    }else{
        NSMutableDictionary* mutableDic = [NSMutableDictionary dictionaryWithCapacity:5];
        [mutableDic setValue:QMStringFromNSInteger(self.currentTask.task_id) forKey:@"task_id"];
        [mutableDic setValue:[[NSDate new] dateToTimeStamp] forKey:@"add_time"];
        [mutableDic setValue:TextFromNSString(dateToday) forKey:@"add_date"];
        [mutableDic setValue:@1 forKey:@"count"];
        [mutableDic setValue:@(PGConfigMgr.TomatoLength) forKey:@"length"];
        [self.dbMgr insertDataIntoTableWithName:tomato_record_table andKeyValues:mutableDic.copy];
    }
    [self.dbMgr.database close];
    [self taskCheckinWithID:self.currentTask.task_id andDateStr:dateToday];
}

- (void)taskCheckinWithID:(NSInteger)task_id andDateStr:(NSString*)dateStr{
    [self.dbMgr.database open];
    NSDictionary* tuple = [self.dbMgr getAllTuplesFromTabel:check_in_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateStr)]]].firstObject;
    if (!tuple) {
        NSMutableDictionary* mutableDic = [NSMutableDictionary dictionaryWithCapacity:5];
        [mutableDic setValue:QMStringFromNSInteger(task_id) forKey:@"task_id"];
        [mutableDic setValue:[[NSDate new] dateToTimeStamp] forKey:@"add_time"];
        [mutableDic setValue:TextFromNSString(dateStr) forKey:@"add_date"];
        [self.dbMgr insertDataIntoTableWithName:check_in_table andKeyValues:mutableDic.copy];
    }
    [self.dbMgr.database close];
}

- (NSArray*)getCheckinRecordWithTaskID:(NSInteger)task_id{
    [self.dbMgr.database open];
    NSArray* tuples = [self.dbMgr getAllTuplesFromTabel:check_in_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)]];
    NSArray* arr = [tuples valueForKeyPath:@"add_date"];
    [self.dbMgr.database close];
    return arr;
}

- (NSArray*)getTomatoRecordWithTaskID:(NSInteger)task_id{
    [self.dbMgr.database open];
    NSArray* tuples = [self.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)] withSortedMode:NSOrderedAscending andColumnName:@"add_date"];
    [self.dbMgr.database close];
    return tuples;
}

@end
