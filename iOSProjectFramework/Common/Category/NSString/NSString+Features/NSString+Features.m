//
//  NSString+Features.m
//  QMMedical
//
//  Created by quanmai on 2018/5/4.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "NSString+Features.h"

@implementation NSString (Features)

//字符串判空
+ (NSString*)emptyStrJudge:(NSString*)str{
    if (NULLString(str)) {
        return @"";
    }else{
        return str;
    }
}

// 去掉首尾空格和换行符
- (NSString *)trimming{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//判断是不是纯数字
- (BOOL)isNumStr{
    if ([[self stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]]trimming].length >0) {
        return NO;
    }else{
        return YES;
    }
}


@end
