//
//  DJDatabaseManager.h
//  Accounting
//
//  Created by 洪冬介 on 2017/7/16.
//  Copyright © 2017年 hongdongjie. All rights reserved.
//

#import <fmdb/FMDB.h>
#import "HDJDSQLSearchModel.h"

@interface DJDatabaseManager : FMDatabase

@property (nonatomic, strong) FMDatabase* database;
@property (nonatomic, copy) NSString *database_name;

+ (instancetype)sharedDJDatabaseManager;
- (void)initializeDB;

///创建表格
- (BOOL)createTableWithName:(NSString*)name andKeyValues:(NSDictionary*)key_values;

///插入元素
- (BOOL)insertDataIntoTableWithName:(NSString*)name andKeyValues:(NSDictionary*)key_values;

///更新某一行中的某列
- (BOOL)updateDataIntoTableWithName:(NSString*)name andSearchModel:(HDJDSQLSearchModel*)searchModel andNewModel:(HDJDSQLSearchModel*)newModel;

///更新某一行中的若干列
- (BOOL)updateDataIntoTableWithName:(NSString*)name andSearchModel:(HDJDSQLSearchModel*)searchModel andNewModelArr:(NSArray<HDJDSQLSearchModel*>*)newModelArr;


///删除某个元素
- (BOOL)deleteDataFromTabel:(NSString *)name andSearchModel:(HDJDSQLSearchModel*)searchModel;

///获取某张表的所有属性（即表的首列元素）
- (NSArray*)getAllColumnNameFromTabel:(NSString*)name;

///获取某张表所有的元组（即所有属性的值）
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name;

///通过单个搜索条件，获取某张表所有的元组
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name andSearchModel:(HDJDSQLSearchModel*)searchModel;


/**
 *  {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending}
 *  NSOrderedAscending  //-1：降序
 *  NSOrderedDescending // 1：升序
 *  NSOrderedSame       // 0
 */

///获取某张表所有的元组（即所有属性的值）,并赋予排序属性
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name withSortedMode:(NSComparisonResult)ordered andColumnName:(NSString*)column_name;

///通过单个搜索条件，获取某张表所有的元组,并赋予排序属性
- (NSArray<NSDictionary*>*)getAllTuplesFromTabel:(NSString *)name andSearchModel:(HDJDSQLSearchModel*)searchModel withSortedMode:(NSComparisonResult)ordered andColumnName:(NSString*)column_name;



///求和
/**
 * param_1:
 * param_2:
 * param_3:
 */
- (double)sumFromTabel:(NSString *)name andColumnName:(NSString*)column_name andSearchModel:(HDJDSQLSearchModel*)searchModel;

@end
