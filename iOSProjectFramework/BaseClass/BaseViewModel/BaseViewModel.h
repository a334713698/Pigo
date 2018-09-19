//
//  BaseViewModel.h
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/23.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface BaseViewModel : NSObject<WCSessionDelegate>

@property (nonatomic, strong) WCSession *sessionDefault;

@property (nonatomic, strong) NSDictionary *messageDic;

@end
