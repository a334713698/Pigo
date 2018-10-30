//
//  PGTotalStatisticsChartModel.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/30.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsChartModel.h"

@implementation PGTotalStatisticsChartModel

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    _total = [dataArr valueForKeyPath:@"@sum.intValue"];
}

@end
