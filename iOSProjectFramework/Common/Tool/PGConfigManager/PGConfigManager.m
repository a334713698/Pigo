//
//  PGConfigManager.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/12.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGConfigManager.h"

#define PGConfigDefaultPath [[NSBundle mainBundle] pathForResource:@"PGConfigDefault" ofType:@"plist"]
//#define PGConfigPath ([NSString stringWithFormat:@"%@/PGConfig.plist",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject])
#define PGConfigFilePath ([[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.hdj.pigo"] URLByAppendingPathComponent:@"PGConfigDefault.plist"].absoluteString)

@implementation PGConfigManager

SYNTHESIZE_SINGLETON_FOR_CLASS(PGConfigManager)

- (void)setup{
    
//    NSMutableString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject.mutableCopy;
//    [path appendString:@"/PGConfig.plist"];
    
    
    NSMutableDictionary* configDic;

    if ([[NSFileManager defaultManager] fileExistsAtPath:PGConfigFilePath]) {
        configDic = [NSMutableDictionary dictionaryWithContentsOfFile:PGConfigFilePath];
    }else{
        configDic = [NSMutableDictionary dictionaryWithContentsOfFile:PGConfigDefaultPath];
        if ([[NSFileManager defaultManager] createFileAtPath:PGConfigFilePath contents:[NSData new] attributes:nil]) {
            DLog(@"创建成功");
        }else{
            DLog(@"创建失败");
        }
    }
    
    [self setValuesForKeysWithDictionary:configDic];
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
//    NSMutableString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject.mutableCopy;
//    [path appendString:@"/PGConfig.plist"];
    
    NSMutableDictionary* config = [self mj_keyValues];
    DLog(@"%@",config);
    if ([config writeToFile:PGConfigFilePath atomically:YES]) {
        DLog(@"写入成功");
    }else{
        DLog(@"写入失败");
    }
    
}

@end
