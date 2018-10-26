//
//  PGTotalStatisticsViewModel.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/25.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTotalStatisticsViewModel : BaseViewModel

+ (NSArray*)getItemsArr;

+ (NSArray<NSArray*>*)getCellNameArr;

+ (NSArray<PGTomatoRecordModel*>*)getAllEnableRecordTomato;

+ (NSArray*)getCategoriesSetWithType:(PGStatisticsPeriodType)type;

+ (NSArray*)getSeriesSetWithType:(PGStatisticsPeriodType)type;

@end

NS_ASSUME_NONNULL_END
