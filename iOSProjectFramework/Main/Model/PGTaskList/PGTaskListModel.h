//
//  PGTaskListModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/14.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseModel.h"

@interface PGTaskListModel : BaseModel

@property (nonatomic, assign) long add_time;

@property (nonatomic, assign) NSInteger task_id;

@property (nonatomic, copy) NSString *task_name;

@property (nonatomic, assign) BOOL is_default;



@property (nonatomic, assign) NSInteger count;

@end
