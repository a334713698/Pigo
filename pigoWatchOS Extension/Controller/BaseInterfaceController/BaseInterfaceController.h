//
//  BaseInterfaceController.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "PGTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseInterfaceController : WKInterfaceController<WCSessionDelegate>

@property (nonatomic, strong) WCSession *sessionDefault;

@property (nonatomic, strong) NSDictionary *messageDic;

@end

NS_ASSUME_NONNULL_END
