//
//  PGStatisticsAndCheckinViewModel.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/22.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGStatisticsAndCheckinViewModel : BaseViewModel

+ (NSArray*)getCategoriesSetWithType:(PGStatisticsPeriodType)type;

+ (NSArray*)getSeriesSetWithType:(PGStatisticsPeriodType)type andDataType:(PGStatisticsChartDataType)dataType andTaskID:(NSInteger)task_id;

@end

NS_ASSUME_NONNULL_END
