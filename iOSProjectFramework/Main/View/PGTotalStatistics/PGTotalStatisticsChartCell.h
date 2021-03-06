//
//  PGTotalStatisticsChartCell.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGTotalStatisticsChartCell : UITableViewCell

@property (nonatomic, strong) UILabel *nodataLab;

- (void)updatePieCharWithPeriodType:(PGStatisticsPeriodType)periodType dataType:(PGStatisticsChartDataType)dataType;

@end

NS_ASSUME_NONNULL_END
