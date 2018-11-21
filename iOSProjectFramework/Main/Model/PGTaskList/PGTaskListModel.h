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
@property (nonatomic, assign) long delete_time;

@property (nonatomic, assign) NSInteger task_id;

@property (nonatomic, copy) NSString *task_name;
@property (nonatomic, copy) NSString *bg_color;

@property (nonatomic, assign) BOOL is_default;
//0：未被删除，1：已删除，2：彻底删除
@property (nonatomic, assign) BOOL is_delete;

@property (nonatomic, assign) NSInteger priority;



@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger length;

@end
