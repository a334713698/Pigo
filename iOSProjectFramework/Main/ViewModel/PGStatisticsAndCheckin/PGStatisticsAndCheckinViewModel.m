//
//  PGStatisticsAndCheckinViewModel.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/22.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsAndCheckinViewModel.h"

@implementation PGStatisticsAndCheckinViewModel

+ (NSArray*)getCategoriesSetWithType:(PGStatisticsPeriodType)type{
    if (type == PGStatisticsPeriodTypeWeek) {
        return @[@"周一",@"周二",@"周三",@"周四", @"周五",@"周六",@"周日"];
    }else if (type == PGStatisticsPeriodTypeMonth){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 1; i <= [NSDate convertDateToTotalDays:[NSDate new]]; i++) {
            [arr addObject:QMStringFromNSInteger(i)];
        }
        return arr;
    }else{
        return @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    }
}

+ (NSArray*)getSeriesSetWithType:(PGStatisticsPeriodType)type andDataType:(PGStatisticsChartDataType)dataType andTaskID:(NSInteger)task_id{
    [PGUserModelInstance.dbMgr.database open];
    
    NSString* keyStr = (dataType == PGStatisticsChartDataTypeCount)? @"count" : @"length";
    
    if (type == PGStatisticsPeriodTypeWeek) {
        NSMutableArray *arr = [NSMutableArray array];
        NSInteger weekDay = [NSDate convertDateToWeekDay:[NSDate new]];
        for (NSInteger i = 1; i < weekDay; i++) {
            NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate getDateFrom:[NSDate new] offsetDays:-(weekDay-i)]];
            NSDictionary* tuple = [PGUserModelInstance.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateStr)]]].firstObject;
            [arr addObject:@([tuple[keyStr] integerValue])];
        }
        for (NSInteger i = weekDay; i <= 7; i++) {
            NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate getDateFrom:[NSDate new] offsetDays:(i-weekDay)]];
            NSDictionary* tuple = [PGUserModelInstance.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateStr)]]].firstObject;
            [arr addObject:@([tuple[keyStr] integerValue])];
        }
        [PGUserModelInstance.dbMgr.database close];
        return arr.copy;
    }else if (type == PGStatisticsPeriodTypeMonth){
        NSMutableArray *arr = [NSMutableArray array];
        NSInteger dateDay = [NSDate convertDateToDay:[NSDate new]];
        NSInteger daysInMonth = [NSDate convertDateToTotalDays:[NSDate new]];
        for (NSInteger i = 1; i < dateDay; i++) {
            NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate getDateFrom:[NSDate new] offsetDays:-(dateDay-i)]];
            NSDictionary* tuple = [PGUserModelInstance.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateStr)]]].firstObject;
            [arr addObject:@([tuple[keyStr] integerValue])];
        }
        for (NSInteger i = dateDay; i <= daysInMonth; i++) {
            NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate getDateFrom:[NSDate new] offsetDays:(i-dateDay)]];
            NSDictionary* tuple = [PGUserModelInstance.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateStr)]]].firstObject;
            [arr addObject:@([tuple[keyStr] integerValue])];
        }
        [PGUserModelInstance.dbMgr.database close];
        return arr;
    }else{
        NSMutableArray *arr = [NSMutableArray array];
        NSInteger monthIndex = [NSDate convertDateToMonth:[NSDate new]];
        NSInteger monthsInYear = 12;
        for (NSInteger i = 1; i < monthIndex; i++) {
            NSDate *monthDate = [NSDate getDateFrom:[NSDate new] offsetMonths:-(monthIndex-i)];
            NSInteger daysInMonth = [NSDate convertDateToTotalDays:monthDate];

            NSString* min = [NSString stringWithFormat:@"%@%02d",[NSDate dateToCustomFormateString:@"yyyyMM" andDate:monthDate],1];
            NSString* max = [NSString stringWithFormat:@"%@%02ld",[NSDate dateToCustomFormateString:@"yyyyMM" andDate:monthDate],daysInMonth];

            NSInteger total = [PGUserModelInstance.dbMgr sumFromTabel:tomato_record_table andColumnName:keyStr andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"<=" andSpecificValue:max],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@">=" andSpecificValue:min]]];
            [arr addObject:@(total)];
        }
        for (NSInteger i = monthIndex; i <= monthsInYear; i++) {
            NSDate *monthDate = [NSDate getDateFrom:[NSDate new] offsetMonths:(i-monthIndex)];
            NSInteger daysInMonth = [NSDate convertDateToTotalDays:monthDate];
            
            NSString* min = [NSString stringWithFormat:@"%@%02d",[NSDate dateToCustomFormateString:@"yyyyMM" andDate:monthDate],1];
            NSString* max = [NSString stringWithFormat:@"%@%02ld",[NSDate dateToCustomFormateString:@"yyyyMM" andDate:monthDate],daysInMonth];
            
            NSInteger total = [PGUserModelInstance.dbMgr sumFromTabel:tomato_record_table andColumnName:keyStr andSearchModels:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task_id)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"<=" andSpecificValue:max],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@">=" andSpecificValue:min]]];
            [arr addObject:@(total)];
        }

        [PGUserModelInstance.dbMgr.database close];
        return arr.copy;
    }
}

@end
