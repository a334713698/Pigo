//
//  PGTotalStatisticsChartModel.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/30.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTotalStatisticsChartModel : BaseModel

@property (nonatomic, strong) PGTaskListModel *taskModel;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSNumber* total;

@end

NS_ASSUME_NONNULL_END
