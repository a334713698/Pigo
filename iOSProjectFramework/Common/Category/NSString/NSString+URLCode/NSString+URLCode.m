//
//  NSString+URLCode.m
//  QMMedical
//
//  Created by quanmai on 2018/5/3.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "NSString+URLCode.h"

@implementation NSString (URLCode)

//上传数据转码
- (NSString*)URLEnCode{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
//使用数据解码
- (NSString*)URLDeCode{
    return [self stringByRemovingPercentEncoding];
//    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
