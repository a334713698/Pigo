//
//  WKWatchTransTool.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/21.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

#define WKWatchTransToolInstance [WKWatchTransTool sharedWKWatchTransTool]

NS_ASSUME_NONNULL_BEGIN

@interface WKWatchTransTool : NSObject<WCSessionDelegate>

PROPERTY_SINGLETON_FOR_CLASS(WKWatchTransTool)

@property (nonatomic, strong) WCSession *sessionDefault;

@property (nonatomic, strong) NSDictionary *messageDic;

+ (BOOL)canSendMsgToiPhone;

@end

NS_ASSUME_NONNULL_END
