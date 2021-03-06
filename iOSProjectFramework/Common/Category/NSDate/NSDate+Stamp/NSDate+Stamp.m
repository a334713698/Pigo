//
//  NSDate+Stamp.m
//  Indiana
//
//  Created by irene on 16/4/7.
//  Copyright © 2016年 HZYuanzhoulvNetwork. All rights reserved.
//

#import "NSDate+Stamp.h"

@implementation NSDate (Stamp)
+ (NSTimeInterval)nowStamp{
    return [[NSDate new] timeIntervalSince1970];
}


/**
 *  时间转换成时间戳
 *
 *  @return 时间戳
 */
- (NSString *)dateToTimeStamp {
    return [NSString stringWithFormat:@"%.0lf", [self timeIntervalSince1970]];
}

/**
 *  时间戳转换成当前时间
 *
 *  @param timeStamp 时间戳
 *
 *  @return 当前时间
 */

+ (NSDate *)timeStampToDateWithTimeStamp:(id)timeStamp {
    NSString *arg = timeStamp;
    
    if (![timeStamp isKindOfClass:[NSString class]]) {
        arg = [NSString stringWithFormat:@"%@", timeStamp];
    }
    
    NSTimeInterval time = [arg doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:time];
}

/**
 *  当前时间转成字符串
 *
 *  @param date 当前时间
 *
 *  @return 字符串形式
 */
+ (NSString *)dateToString:(NSDate *)date {
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString
    return currentDateString;
}


/**
 *  转换成昨天，今天，明天字符串
 *
 *  @param date 当前日期
 *
 *  @return 字符串形式
 */
+ (NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString]) {
        return [NSString stringWithFormat:@"今天%@",[[NSDate dateToString:date] substringWithRange:NSMakeRange(10, 6)]];
    } else if ([dateString isEqualToString:yesterdayString]) {
        return [NSString stringWithFormat:@"昨天%@",[[NSDate dateToString:date] substringWithRange:NSMakeRange(10, 6)]];
    }else if ([dateString isEqualToString:tomorrowString]) {
        return [NSString stringWithFormat:@"明天%@",[[NSDate dateToString:date] substringWithRange:NSMakeRange(10, 6)]];
    } else {
        return [[NSDate dateToString:date] substringToIndex:10];
    }
}

/**
 *  秒数转换成时分秒（xx小时xx分钟xx秒）
 *
 *  @param seconds 秒数
 *
 *  @return 字符串形式
 */
+ (NSString*)secondsToHMS:(long long)seconds{
    NSInteger hour = seconds / 3600;
    NSInteger min = seconds % 3600 / 60;
    NSInteger sec = seconds % 3600 % 60;
//    DLog(@"%ld:%ld:%ld",hour,min,sec);
    NSString *str;
    if (hour) {
        str = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,min,sec];
    }else if (min) {
        str = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    }else{
        str = [NSString stringWithFormat:@"%02ld",sec];
    }
    return str;
}

+ (NSString*)pg_secondsToHMS:(long long)seconds{
    NSInteger min = seconds / 60;
    NSInteger sec = seconds % 3600 % 60;
//    DLog(@"%ld:%ld",min,sec);
    NSString *str = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    return str;
}


///自定义格式，转换时间，直接传stamp
+ (NSString *)dateToCustomFormateString:(NSString*)formate andTimeStamp:(id)timeStamp{
    return [self dateToCustomFormateString:formate andDate:[NSDate timeStampToDateWithTimeStamp:timeStamp]];
}

/**
 *  自定义格式，转换时间
 *
 *  @param formate 日期格式
 *  @param date    当前日期
 *
 *  @return 字符串形式
 */
+ (NSString *)dateToCustomFormateString:(NSString*)formate andDate:(NSDate *)date{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:formate];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString
    return currentDateString;
}

//获取今天的日期（格式：yyyyMMdd）
+ (NSString *)getTodayDateStr{
    return [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
}

//时间转NSDate
+ (NSDate*)dateStrToDate:(NSString*)dateStr andFormateString:(NSString*)formate{
    NSString *string = dateStr;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = formate;
    NSDate *date = [format dateFromString:string];
    return date;
}

@end
