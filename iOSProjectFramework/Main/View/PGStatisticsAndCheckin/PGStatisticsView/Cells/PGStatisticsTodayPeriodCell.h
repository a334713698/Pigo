//
//  PGStatisticsTodayPeriodCell.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGStatisticsTodayPeriodCell;
@protocol PGStatisticsTodayPeriodCellDelegate<NSObject>

- (void)periodCell:(PGStatisticsTodayPeriodCell*)cell andType:(PGStatisticsPeriodType)type;

@end


NS_ASSUME_NONNULL_BEGIN

@interface PGStatisticsTodayPeriodCell : UITableViewCell

@property (nonatomic, weak) id<PGStatisticsTodayPeriodCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
