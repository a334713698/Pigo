//
//  BaseViewModel.m
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/23.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

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
        _messageDic = @{@"message":@"这是一条来自iPhone的信息"};
    }
    return _messageDic;
}
@end
