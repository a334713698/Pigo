//
//  PGTotalStatisticsViewModel.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/25.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"
#import "PGTotalStatisticsChartModel.h"
#import "PGTotalStatisticsItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTotalStatisticsViewModel : BaseViewModel

+ (NSArray<PGTotalStatisticsItemModel*>*)getItemsArrWithType:(PGStatisticsPeriodType)periodType;

+ (NSArray<NSArray*>*)getCellNameArr;

+ (NSArray*)getCategoriesSetWithType:(PGStatisticsPeriodType)type;

+ (NSArray<PGTotalStatisticsChartModel*>*)getSeriesSetWithType:(PGStatisticsPeriodType)type andDataType:(PGStatisticsChartDataType)dataType;

@end

NS_ASSUME_NONNULL_END
