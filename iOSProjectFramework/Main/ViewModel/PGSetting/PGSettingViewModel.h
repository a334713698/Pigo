//
//  PGSettingViewModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"

@interface PGSettingViewModel : BaseViewModel

@property (nonatomic, copy) CommonBlcok recoverHandler;


+ (NSArray*)gettingCellData;

+ (void)watch_updateSettingConfig;

//数据序列化
+ (void)dataSerialize;
//反序列化
- (void)deserializationCompelete:(CommonBlcok)recoverHandler;

- (void)test;
@end
