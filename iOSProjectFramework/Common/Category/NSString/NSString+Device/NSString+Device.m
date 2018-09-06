//
//  NSString+Device.m
//  QMMedical
//
//  Created by quanmai on 2018/6/11.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "NSString+Device.h"

@implementation NSString (Device)

+ (NSString*)getDeviceUUID{
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"My UUID:%@",deviceUUID);
    return deviceUUID;
}

@end
