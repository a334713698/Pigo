//
//  PGTotalStatisticsViewModel.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/25.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsViewModel.h"

@implementation PGTotalStatisticsViewModel

+ (NSArray*)getItemsArr{
    return @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
}

+ (NSArray<NSArray*>*)getCellNameArr{
    return @[
  @[@"PGStatisticsTodayDataCell"],
  @[@"PGStatisticsChartCell",@"PGStatisticsTodayPeriodCell",@"PGStatisticsChartCell"],
  @[@"PGTotalStatisticsChartCell"]
             ];
}

+ (NSArray<PGTomatoRecordModel*>*)getAllEnableRecordTomato{
    [PGUserModelInstance.dbMgr.database open];
    //获取所有可用任务
    NSArray<PGTaskListModel*>* taskLists = [PGTaskListModel mj_objectArrayWithKeyValuesArray:[PGUserModelInstance.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"0"]]];
    if (!taskLists.count) {
        return nil;
    }
    //收集所有任务的task_id
    NSMutableArray<HDJDSQLSearchModel*>* termsArr = [NSMutableArray array];
    for (PGTaskListModel* task in taskLists) {
        [termsArr addObject:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task.task_id)]];
    }

    //
    NSArray* tuples = [PGUserModelInstance.dbMgr getAllTuplesFromTabel:tomato_record_table];
    if (!tuples.count) {
        return nil;
    }
    NSArray* models = [PGTomatoRecordModel mj_objectArrayWithKeyValuesArray:tuples];

    [PGUserModelInstance.dbMgr.database close];
    return nil;
}

+ (NSArray*)getCategoriesSetWithType:(PGStatisticsPeriodType)type{
    
    return nil;
}

+ (NSArray*)getSeriesSetWithType:(PGStatisticsPeriodType)type{
    
    return nil;
}

@end
