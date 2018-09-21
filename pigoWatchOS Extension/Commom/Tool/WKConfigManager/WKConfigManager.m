//
//  WKConfigManager.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "WKConfigManager.h"

@implementation WKConfigManager

SYNTHESIZE_SINGLETON_FOR_CLASS(WKConfigManager)

- (void)setup{
    NSDictionary* dataDic = [USER_DEFAULT objectForKey:Config_Setting];
    if (dataDic) {
        [self mj_setKeyValues:dataDic];
    }
}

@end
