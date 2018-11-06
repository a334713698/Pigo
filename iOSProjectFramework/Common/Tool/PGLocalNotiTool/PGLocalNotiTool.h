//
//  PGLocalNotiTool.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/11/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGLocalNotiTool : NSObject

+ (void)registerUserNotiSettings;

+ (void)handleUserNotiWithIdentifier:(NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
