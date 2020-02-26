//
//  WKUserModel.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2020/2/26.
//  Copyright © 2020 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGTaskListModel.h"

NS_ASSUME_NONNULL_BEGIN

#define WKUserModelInstance [WKUserModel sharedWKUserModel]

@interface WKUserModel : NSObject

PROPERTY_SINGLETON_FOR_CLASS(WKUserModel)

@property (nonatomic, strong) PGTaskListModel *currentTask;

@property (nonatomic, assign) PGFocusState currentFocusState;

- (void)setup;

- (void)completeATomato;

- (void)completeATomatoAt:(NSDate*)date;

- (void)taskCheckinWithID:(NSInteger)task_id andDateStr:(NSString*)dateStr isAuto:(BOOL)isAuto;

- (NSArray*)getCheckinRecordWithTaskID:(NSInteger)task_id;

- (NSArray*)getTomatoRecordWithTaskID:(NSInteger)task_id;

- (BOOL)checkeMissingTomato;

- (void)updateTomato;

@end

NS_ASSUME_NONNULL_END
