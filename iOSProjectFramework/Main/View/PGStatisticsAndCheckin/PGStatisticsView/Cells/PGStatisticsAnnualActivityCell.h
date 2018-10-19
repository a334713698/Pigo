//
//  PGStatisticsAnnualActivityCell.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGTomatoRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGStatisticsAnnualActivityCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary<NSString*,PGTomatoRecordModel*> *recordMutableDic;

@end

NS_ASSUME_NONNULL_END
