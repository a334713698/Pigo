//
//  PGTomatoRecordModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTomatoRecordModel : BaseModel

@property (nonatomic, assign) NSInteger task_id;
@property (nonatomic, assign) NSInteger tomato_id;
@property (nonatomic, copy) NSString *add_date;
@property (nonatomic, assign) long add_time;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) long length;//分钟


@end

NS_ASSUME_NONNULL_END
