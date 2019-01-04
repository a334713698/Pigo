//
//  PGTaskListViewModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"
#import "PGTaskListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTaskListViewModel : BaseViewModel

- (void)saveListData:(NSArray<PGTaskListModel*>*)taskModels;
- (void)watch_updateTaskList:(NSArray<PGTaskListModel*>*)list;

@end

NS_ASSUME_NONNULL_END
