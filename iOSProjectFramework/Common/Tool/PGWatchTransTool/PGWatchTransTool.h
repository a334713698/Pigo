//
//  PGWatchTransTool.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

NS_ASSUME_NONNULL_BEGIN

#define WatchTransToolInstance [PGWatchTransTool sharedPGWatchTransTool]

@interface PGWatchTransTool : NSObject<WCSessionDelegate>

PROPERTY_SINGLETON_FOR_CLASS(PGWatchTransTool)

@property (nonatomic, strong) WCSession *sessionDefault;

@property (nonatomic, strong) NSDictionary *messageDic;

+ (BOOL)canSendMsgToWatch;

//发送前台字典数据
+ (void)sendMessageObj:(id)messageObj type:(PGTransmittedtType)type replyHandler:(nullable void (^)(NSDictionary<NSString *, id> *replyMessage))replyHandler errorHandler:(nullable void (^)(NSError *error))errorHandler;

@end

NS_ASSUME_NONNULL_END
