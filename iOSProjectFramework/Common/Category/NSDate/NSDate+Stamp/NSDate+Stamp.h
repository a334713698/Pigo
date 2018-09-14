//
//  NSDate+Stamp.h
//  Indiana
//
//  Created by irene on 16/4/7.
//  Copyright © 2016年 HZYuanzhoulvNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Stamp)
///时间转换成时间戳
- (NSString *)dateToTimeStamp;
///时间戳转换成时间
+ (NSDate *)timeStampToDateWithTimeStamp:(id)timeStamp;

///秒数转换成时分秒（xx小时xx分钟xx秒）
+ (NSString*)secondsToHMS:(long long)seconds;

+ (NSString*)pg_secondsToHMS:(long long)seconds;

///转换成昨天，今天，明天字符串
+ (NSString *)compareDate:(NSDate *)date;

///自定义格式，转换时间，直接传stamp
+ (NSString *)dateToCustomFormateString:(NSString*)formate andTimeStamp:(id)timeStamp;
///自定义格式，转换时间
+ (NSString *)dateToCustomFormateString:(NSString*)formate andDate:(NSDate *)date;

///聊天界面的时间显示
+ (NSString *)transFormTimeStampForVoiceReplyWithHHMMStr:(NSDate *)date;

@end
