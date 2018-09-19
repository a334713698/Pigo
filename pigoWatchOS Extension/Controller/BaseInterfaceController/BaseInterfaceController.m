//
//  BaseInterfaceController.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseInterfaceController.h"

@interface BaseInterfaceController ()

@end

@implementation BaseInterfaceController

- (WCSession *)sessionDefault{
    if (!_sessionDefault) {
        _sessionDefault = [WCSession defaultSession];
        _sessionDefault.delegate = self;
        [_sessionDefault activateSession];
    }
    return _sessionDefault;
}

- (NSDictionary *)messageDic{
    if (!_messageDic) {
        _messageDic = @{@"message":@"这是一条来自watch信息"};
    }
    return _messageDic;
}

@end



