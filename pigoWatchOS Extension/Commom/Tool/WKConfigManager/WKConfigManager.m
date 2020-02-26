//
//  WKConfigManager.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "WKConfigManager.h"

#define PGExConfigDefaultPath [[NSBundle mainBundle] pathForResource:@"PGExConfigDefault" ofType:@"plist"]
#define PGExConfigPath ([NSString stringWithFormat:@"%@/PGExConfig.plist",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject])

@implementation WKConfigManager

SYNTHESIZE_SINGLETON_FOR_CLASS(WKConfigManager)

//- (void)setup{
//    NSDictionary* dataDic = [USER_DEFAULT objectForKey:Config_Setting];
//    if (dataDic) {
//        [self mj_setKeyValues:dataDic];
//    }
//}

- (void)setup{
        
    NSMutableDictionary* configDic;

    if ([[NSFileManager defaultManager] fileExistsAtPath:PGExConfigPath]) {
        configDic = [NSMutableDictionary dictionaryWithContentsOfFile:PGExConfigPath];
    }else{
        configDic = [NSMutableDictionary dictionaryWithContentsOfFile:PGExConfigDefaultPath];
        if ([[NSFileManager defaultManager] createFileAtPath:PGExConfigPath contents:[NSData new] attributes:nil]) {
            DLog(@"创建成功");
        }else{
            DLog(@"创建失败");
        }
    }
    
    [self setValuesForKeysWithDictionary:configDic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    DLog(@"forUndefinedKey：%@",key);
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
//    NSMutableString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject.mutableCopy;
//    [path appendString:@"/PGConfig.plist"];
    
    NSMutableDictionary* config = [self mj_keyValues];
    DLog(@"%@",config);
    if ([config writeToFile:PGExConfigPath atomically:YES]) {
        DLog(@"写入成功");
    }else{
        DLog(@"写入失败");
    }
    
}


@end
