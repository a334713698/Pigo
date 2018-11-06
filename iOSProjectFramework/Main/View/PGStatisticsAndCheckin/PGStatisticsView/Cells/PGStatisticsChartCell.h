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

@property (nonatomic, copy) NSString *bg_color;

- (void)updateCharWithTaskID:(NSInteger)task_id periodType:(PGStatisticsPeriodType)periodType dataType:(PGStatisticsChartDataType)dataType;

- (void)updateTotalStatistcsCharWithPeriodType:(PGStatisticsPeriodType)periodType dataType:(PGStatisticsChartDataType)dataType;

@end

NS_ASSUME_NONNULL_END
