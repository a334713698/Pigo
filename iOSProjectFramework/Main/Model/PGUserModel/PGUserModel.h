//
//  PGUserModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGTaskListModel.h"
#import "DJDatabaseManager.h"

NS_ASSUME_NONNULL_BEGIN

#define PGUserModelInstance [PGUserModel sharedPGUserModel]

@interface PGUserModel : NSObject

PROPERTY_SINGLETON_FOR_CLASS(PGUserModel)

@property (nonatomic, strong) DJDatabaseManager* dbMgr;

@property (nonatomic, strong) PGTaskListModel *currentTask;

@property (nonatomic, assign) PGFocusState currentFocusState;

- (void)setup;
- (void)completeATomato;
- (void)completeATomatoAt:(NSDate*)date;

- (NSArray*)getCheckinRecordWithTaskID:(NSInteger)task_id;
- (NSArray*)getTomatoRecordWithTaskID:(NSInteger)task_id;

- (void)taskCheckinWithID:(NSInteger)task_id andDateStr:(NSString*)dateStr isAuto:(BOOL)isAuto;

- (BOOL)checkeMissingTomato;

- (void)updateTomato;

@end

NS_ASSUME_NONNULL_END
