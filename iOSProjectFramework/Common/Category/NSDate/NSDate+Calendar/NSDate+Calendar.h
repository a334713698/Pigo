//
//  NSDate+Calendar.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/22.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Calendar)

//根据date获取日
+ (NSInteger)convertDateToDay:(NSDate *)date;

//根据date获取月
+ (NSInteger)convertDateToMonth:(NSDate *)date;

//根据date获取年
+ (NSInteger)convertDateToYear:(NSDate *)date;

//根据date获取当天周几 (美国时间周日-周六为 1-7,改为0-6方便计算)
+ (NSInteger)convertDateToWeekDay:(NSDate *)date;

//根据date获取当月第一天周几
+ (NSInteger)convertDateToFirstWeekDay:(NSDate *)date;

//根据date获取当月总天数
+ (NSInteger)convertDateToTotalDays:(NSDate *)date;

//根据date获取偏移指定天数的date
+ (NSDate *)getDateFrom:(NSDate *)date offsetDays:(NSInteger)offsetDays;
//根据date获取偏移指定月数的date
+ (NSDate *)getDateFrom:(NSDate *)date offsetMonths:(NSInteger)offsetMonths;
//根据date获取偏移指定年数的date
+ (NSDate *)getDateFrom:(NSDate *)date offsetYears:(NSInteger)offsetYears;


@end

NS_ASSUME_NONNULL_END
