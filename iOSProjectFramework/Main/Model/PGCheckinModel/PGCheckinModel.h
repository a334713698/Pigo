//
//  PGCheckinModel.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/17.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGCheckinModel : BaseModel

@property (nonatomic, assign) NSInteger task_id;
@property (nonatomic, assign) NSInteger checkin_id;
@property (nonatomic, copy) NSString *add_date;
@property (nonatomic, assign) long add_time;

@end

NS_ASSUME_NONNULL_END
