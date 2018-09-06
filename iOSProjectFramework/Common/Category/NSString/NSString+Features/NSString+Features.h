//
//  NSString+Features.h
//  QMMedical
//
//  Created by quanmai on 2018/5/4.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Features)

//字符串判空
+ (NSString*)emptyStrJudge:(NSString*)str;

// 去掉首尾空格和换行符
- (NSString *)trimming;

// 判断是否为数组
- (BOOL)isNumStr;

@end
