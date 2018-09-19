//
//  PGTool.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTool.h"

@implementation PGTool

+ (NSData*)dicToData:(NSDictionary*)obj{
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

+ (NSDictionary*)dataToDic:(NSData*)data{
    NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dictFromData;
}

@end
