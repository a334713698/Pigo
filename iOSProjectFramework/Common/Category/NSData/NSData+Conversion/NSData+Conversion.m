//
//  NSData+Conversion.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "NSData+Conversion.h"

@implementation NSData (Conversion)


+ (NSData*)dicToData:(NSDictionary*)obj{
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

+ (NSData*)arrToData:(NSArray*)obj{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    return data;
}


+ (id)dataToObj:(NSData*)data{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}


+ (NSDictionary*)dataToDic:(NSData*)data{
    NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dictFromData;
}

+ (NSArray*)dataToArr:(NSData*)data{
    NSArray *arrFromData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return arrFromData;
}

@end
