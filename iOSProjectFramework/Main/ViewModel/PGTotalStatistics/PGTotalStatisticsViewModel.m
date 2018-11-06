//
//  PGTotalStatisticsViewModel.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/25.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsViewModel.h"
#import "PGStatisticsAndCheckinViewModel.h"

@implementation PGTotalStatisticsViewModel

+ (NSArray<PGTotalStatisticsItemModel*>*)getItemsArrWithType:(PGStatisticsPeriodType)periodType{
    NSArray<PGTotalStatisticsChartModel*>* seriesCountArr = [PGTotalStatisticsViewModel getSeriesSetWithType:periodType andDataType:PGStatisticsChartDataTypeCount];
    NSArray<PGTotalStatisticsChartModel*>* seriesLengthArr = [PGTotalStatisticsViewModel getSeriesSetWithType:periodType andDataType:PGStatisticsChartDataTypeLength];
    
    NSUInteger itemCount = seriesCountArr.count;
    
    NSInteger totalCount = [[[seriesCountArr valueForKeyPath:@"total"] valueForKeyPath:@"@sum.intValue"] integerValue];
    NSInteger totalLength = [[[seriesLengthArr valueForKeyPath:@"total"] valueForKeyPath:@"@sum.intValue"] integerValue];

    if (!totalCount){
        return nil;
    }
    
    NSMutableArray* elementsArr = [NSMutableArray array];
    for (NSInteger i = 0; i < itemCount; i++) {
        PGTotalStatisticsChartModel* countModel = seriesCountArr[i];
        PGTotalStatisticsChartModel* lengthModel = seriesLengthArr[i];

        PGTotalStatisticsItemModel* model = [PGTotalStatisticsItemModel new];
        model.taskModel = countModel.taskModel;
        model.totalCount = [[countModel.dataArr valueForKeyPath:@"@sum.intValue"] integerValue];
        model.totalLength = [[lengthModel.dataArr valueForKeyPath:@"@sum.intValue"] integerValue];
        model.countPercent = 1.0 * model.totalCount / totalCount;
        model.lengthPercent = 1.0 * model.totalLength / totalLength;
        if (!model.totalCount) {
            continue;
        }
        [elementsArr addObject:model];
    }

    return elementsArr.copy;
}

+ (NSArray<NSArray*>*)getCellNameArr{
    return @[
  @[@"PGStatisticsTodayDataCell"],
  @[@"PGStatisticsChartCell",@"PGStatisticsTodayPeriodCell",@"PGStatisticsChartCell"],
  @[@"PGTotalStatisticsChartCell"]
             ];
}

+ (NSArray<PGTaskListModel*>*)getAllEnableTask{
    [PGUserModelInstance.dbMgr.database open];
    //获取所有可用任务
    NSArray<PGTaskListModel*>* taskLists = [PGTaskListModel mj_objectArrayWithKeyValuesArray:[PGUserModelInstance.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"0"]]];
    [PGUserModelInstance.dbMgr.database close];
    if (!taskLists.count) {
        return nil;
    }else{
        return taskLists;
    }
}

+ (NSArray*)getCategoriesSetWithType:(PGStatisticsPeriodType)type{
    return [PGStatisticsAndCheckinViewModel getCategoriesSetWithType:type];
}

+ (NSArray<PGTotalStatisticsChartModel*>*)getSeriesSetWithType:(PGStatisticsPeriodType)type andDataType:(PGStatisticsChartDataType)dataType{
    NSArray* taskList = [self getAllEnableTask];
    NSMutableArray* tmpArr = [NSMutableArray array];
    for (PGTaskListModel* task in taskList) {
        PGTotalStatisticsChartModel* chartModel = [PGTotalStatisticsChartModel new];
        chartModel.taskModel = task;
        chartModel.dataArr = [PGStatisticsAndCheckinViewModel getSeriesSetWithType:type andDataType:dataType andTaskID:task.task_id];
        NSInteger total = [[chartModel.dataArr valueForKeyPath:@"@sum.intValue"] integerValue];
        if (!total) {
            continue;
        }
        [tmpArr addObject:chartModel];
    }
    return tmpArr.copy;
}

@end
