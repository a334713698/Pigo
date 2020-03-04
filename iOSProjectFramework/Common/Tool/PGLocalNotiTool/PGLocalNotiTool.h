//
//  PGLocalNotiTool.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/11/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGLocalNotiTool : NSObject<UNUserNotificationCenterDelegate>

+ (void)registerUserNotiSettings;

+ (void)handleUserNotiWithIdentifier:(NSString*)identifier;

PROPERTY_SINGLETON_FOR_CLASS(PGLocalNotiTool)

@end

NS_ASSUME_NONNULL_END
