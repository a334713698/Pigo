//
//  DJDatabaseManager.m
//  Accounting
//
//  Created by 洪冬介 on 2017/7/16.
//  Copyright © 2017年 hongdongjie. All rights reserved.
//

#import "DJDatabaseManager.h"

@implementation DJDatabaseManager

SYNTHESIZE_SINGLETON_FOR_CLASS(DJDatabaseManager)


- (FMDatabase *)database{
    if (!_database) {
        NSString* dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:DATABASE_NAME];
        _database = [FMDatabase databaseWithPath:dbPath];
        DLog(@"%@",dbPath);
    }
    return _database;
}

//初始化app数据库数据
- (void)initializeDB{
    //打开数据库对象
    BOOL isOpen = [self.database open];
    
    if (isOpen) {
        [self init_task_list_table];
        [self init_tomato_record_table];
    }else{
        NSLog(@"数据库打开失败");
    }
    
    [self.database close];
}

//创建task_list_table，并插入数据
- (void)init_task_list_table{
    
    BOOL isCreated = [self createTableWithName:task_list_table andKeyValues:@{@"task_id":@"integer primary key",@"task_name":@"text",@"is_default":@"int"}];
    
    if (isCreated) {
        DLog(@"任务表创建成功");
        [self insertDataIntoTableWithName:task_list_table andKeyValues:@{@"task_name":TextFromNSString(@"Swift学习"),@"is_default":@"1"}];
    }
}

//创建tomato_record_table，并插入数据
- (void)init_tomato_record_table{
    
    BOOL isCreated = [self createTableWithName:tomato_record_table andKeyValues:@{@"tomato_id":@"integer primary key",@"task_id":@"integer",@"add_date":@"text",@"add_time":@"long",@"count":@"integer"}];
    
    if (isCreated) {
        DLog(@"番茄记录表创建成功");
    }
}


//创建表
- (BOOL)createTableWithName:(NSString*)name andKeyValues:(NSDictionary*)key_values{
    NSArray* keysArr = [key_values allKeys];
    NSMutableArray* tupleArr = [NSMutableArray array];
    for (NSString* key in keysArr) {
        NSString* value = key_values[key];
        NSString* key_value = [NSString stringWithFormat:@"%@ %@",key,value];
        [tupleArr addObject:key_value];
    }
    NSString* tupleStr = [tupleArr componentsJoinedByString:@","];
    NSString* sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (%@)",name,tupleStr];
    
    BOOL isSuccess = [self.database executeUpdate:sqlStr];
    
    if (isSuccess) {
        DLog(@"%@ 表创建成功",name);
    }else{
        DLog(@"%@ 表创建失败",name);
    }
    return isSuccess;
}

//插入数据
- (BOOL)insertDataIntoTableWithName:(NSString*)name andKeyValues:(NSDictionary*)key_values{
    
    NSArray* keysArr = [key_values allKeys];
    NSMutableArray* valuesArr = [NSMutableArray array];
    for (NSString* key in keysArr) {
        NSString* value = key_values[key];
        [valuesArr addObject:value];
    }
    
    NSString* keysStr = [keysArr componentsJoinedByString:@","];
    NSString* valuesStr = [valuesArr componentsJoinedByString:@","];

    NSString* sqlStr = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)",name,keysStr,valuesStr];

    BOOL isSuccess = [self.database executeUpdate:sqlStr];
    if (isSuccess) {
        DLog(@"%@ 数据插入成功",name);
    }else{
        DLog(@"%@ 数据插入失败",name);
    }
    return isSuccess;
}

//更新数据
- (BOOL)updateDataIntoTableWithName:(NSString*)name andSearchModel:(HDJDSQLSearchModel*)searchModel andNewModel:(HDJDSQLSearchModel*)newModel{
    
    NSString* sqlStr = [NSString stringWithFormat:@"update %@ set %@%@%@ where %@%@%@",name,newModel.attriName,newModel.symbol,newModel.specificValue,searchModel.attriName,searchModel.symbol,searchModel.specificValue];

    BOOL isSuccess = [self.database executeUpdate:sqlStr];
    
    if (isSuccess) {
        DLog(@"%@ 数据更新成功",name);
    }else{
        DLog(@"%@ 数据更新失败",name);
    }

    return isSuccess;
}

///更新某一行中的若干列
- (BOOL)updateDataIntoTableWithName:(NSString*)name andSearchModel:(HDJDSQLSearchModel*)searchModel andNewModelArr:(NSArray<HDJDSQLSearchModel*>*)newModelArr{
    NSMutableArray* newSqlArr = [NSMutableArray new];
    
    for (HDJDSQLSearchModel* newModel in newModelArr) {
        [newSqlArr addObject:[NSString stringWithFormat:@"%@%@%@",newModel.attriName,newModel.symbol,newModel.specificValue]];
    }
    
    NSString* updateStr = [newSqlArr componentsJoinedByString:@","];
    
    NSString* sqlStr = [NSString stringWithFormat:@"update %@ set %@ where %@%@%@",name,updateStr,searchModel.attriName,searchModel.symbol,searchModel.specificValue];
    
    BOOL isSuccess = [self.database executeUpdate:sqlStr];
    
    if (isSuccess) {
        DLog(@"%@ 数据更新成功",name);
    }else{
        DLog(@"%@ 数据更新失败",name);
    }
    
    return isSuccess;
}

///删除某个元素
- (BOOL)deleteDataFromTabel:(NSString *)name andSearchModel:(HDJDSQLSearchModel*)searchModel{
    
    NSString* sqlStr = [NSString stringWithFormat:@"delete from %@ where %@%@%@",name,searchModel.attriName,searchModel.symbol,searchModel.specificValue];

    BOOL isSuccess = [self.database executeUpdate:sqlStr];
    
    if (isSuccess) {
        DLog(@"%@ 数据删除成功",name);
    }else{
        DLog(@"%@ 数据删除失败",name);
    }
    
    return isSuccess;
}

//获取某张表所有的首列元素
- (NSArray*)getAllColumnNameFromTabel:(NSString*)name{
    NSString* sql = [NSString stringWithFormat:@"select * from %@",name];
    FMResultSet *result = [self.database executeQuery:sql];
    return result.columnNameToIndexMap.allKeys;
}

//获取某张表所有的元组
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name{
    NSMutableArray<NSDictionary*>* result_arr = [NSMutableArray array];
    
    NSString* sql = [NSString stringWithFormat:@"select * from %@",name];
    FMResultSet *result = [self.database executeQuery:sql];
    while([result next]) {
        [result_arr addObject:result.resultDictionary];
    }
    
    return [result_arr copy];
}

//通过单个搜索条件，获取某张表所有的元组
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name andSearchModel:(HDJDSQLSearchModel*)searchModel{
    NSMutableArray<NSDictionary*>* result_arr = [NSMutableArray array];
    
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@%@%@",name,searchModel.attriName,searchModel.symbol,searchModel.specificValue];
    FMResultSet *result = [self.database executeQuery:sql];
    while([result next]) {
        [result_arr addObject:result.resultDictionary];
    }
    
    return [result_arr copy];
}
///通过多个搜索条件，获取某张表所有的元组
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name andSearchModels:(NSArray<HDJDSQLSearchModel*>*)searchModels{
    if (searchModels.count<2) {
        return [self getAllTuplesFromTabel:name andSearchModel:searchModels.firstObject];
    }
    NSMutableArray<NSDictionary*>* result_arr = [NSMutableArray array];
    
    NSMutableArray* searchStrArr = [NSMutableArray arrayWithCapacity:searchModels.count];
    for (HDJDSQLSearchModel* searchModel in searchModels) {
        [searchStrArr addObject:[NSString stringWithFormat:@"%@%@%@",searchModel.attriName,searchModel.symbol,searchModel.specificValue]];
    }
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@",name,[searchStrArr componentsJoinedByString:@" and "]];
    FMResultSet *result = [self.database executeQuery:sql];
    while([result next]) {
        [result_arr addObject:result.resultDictionary];
    }
    
    return [result_arr copy];
}

///获取某张表所有的元组（即所有属性的值）,并赋予排序属性
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name withSortedMode:(NSComparisonResult)ordered andColumnName:(NSString*)column_name{
    NSMutableArray<NSDictionary*>* result_arr = [NSMutableArray array];
    
    NSString* sql = [NSString stringWithFormat:@"select * from %@ %@",name,[self getSortedModeStr:ordered andColumnName:column_name]];
    FMResultSet *result = [self.database executeQuery:sql];
    while([result next]) {
        [result_arr addObject:result.resultDictionary];
    }
    
    return [result_arr copy];
}

///通过单个搜索条件，获取某张表所有的元组,并赋予排序属性
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name andSearchModel:(HDJDSQLSearchModel*)searchModel withSortedMode:(NSComparisonResult)ordered andColumnName:(NSString*)column_name{
    NSMutableArray<NSDictionary*>* result_arr = [NSMutableArray array];
    
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@%@%@ %@",name,searchModel.attriName,searchModel.symbol,searchModel.specificValue,[self getSortedModeStr:ordered andColumnName:column_name]];
    FMResultSet *result = [self.database executeQuery:sql];
    while([result next]) {
        [result_arr addObject:result.resultDictionary];
    }
    
    return [result_arr copy];
}


//求和（有搜索要求）
- (double)sumFromTabel:(NSString *)name andColumnName:(NSString*)column_name andSearchModel:(HDJDSQLSearchModel*)searchModel{
    
    NSString* sumResult = @"sumResult";
    NSString* sqlStr = [NSString stringWithFormat:@"select sum(%@) as %@ from %@ where %@%@%@",column_name,sumResult,name,searchModel.attriName,searchModel.symbol,searchModel.specificValue];

    FMResultSet *result = [self.database executeQuery:sqlStr];
    
    double total = 0.0;
    while([result next] && ![result.resultDictionary[sumResult] isKindOfClass:[NSNull class]]) {
        total = [result.resultDictionary[sumResult] doubleValue];
        break;
    }

    return total;
}


#pragma mark - method
- (NSString*)getSortedModeStr:(NSComparisonResult)ordered andColumnName:(NSString*)column_name{
    switch (ordered) {
        case NSOrderedDescending:
            return [NSString stringWithFormat:@"order by %@ desc",column_name];
        case NSOrderedAscending:
            return [NSString stringWithFormat:@"order by %@ asc",column_name];
        default:
            return @"";
    }
}

@end
