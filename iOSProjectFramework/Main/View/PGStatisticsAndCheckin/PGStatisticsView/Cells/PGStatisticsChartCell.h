//
//  PGStatisticsChartCell.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGStatisticsChartCell : UITableViewCell

/**
 *  categoriesSet:x轴数据
 *  seriesSet:y轴数据
 */
- (void)updateChartWithTitle:(NSString*)title categoriesSet:(NSArray*)categoriesSet seriesSet:(NSArray*)seriesSet;

- (void)updateCharWithTaskID:(NSInteger)task_id periodType:(PGStatisticsPeriodType)periodType dataType:(PGStatisticsChartDataType)dataType;

@end

NS_ASSUME_NONNULL_END
