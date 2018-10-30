//
//  PGTotalStatisticsItemModel.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/30.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTotalStatisticsItemModel : BaseModel

@property (nonatomic, strong) PGTaskListModel *taskModel;

@property (nonatomic, assign) double countPercent;
@property (nonatomic, assign) double lengthPercent;

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger totalLength;

@end

NS_ASSUME_NONNULL_END
