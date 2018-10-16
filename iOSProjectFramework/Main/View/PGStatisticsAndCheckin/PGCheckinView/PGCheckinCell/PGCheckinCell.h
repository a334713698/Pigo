//
//  PGCheckinCell.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/16.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CalendarView_Width (SCREEN_WIDTH - 20)
#define CalendarView_Height (SCREEN_HEIGHT * 0.5)

#define CalendarView_Week_TopView_Height 45

#define CalendarView_Content_Item_Height 45
#define DayCountOfWeek 7

#define unSelectedIndex -1

NS_ASSUME_NONNULL_BEGIN

@interface PGCheckinCell : UITableViewCell

@property (nonatomic, strong) NSDate* date;

//本月日期所需要占用的行数
+ (NSInteger)getTotalRowsInThisMonth:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
