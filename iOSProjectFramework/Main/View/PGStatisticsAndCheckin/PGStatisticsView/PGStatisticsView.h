//
//  PGStatisticsView.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGStatisticsView : BaseView

@property (nonatomic, copy) NSString *bg_color;

@property (nonatomic, assign) NSInteger task_id;

- (instancetype)initWithTaskID:(NSInteger)task_id andThemeColor:(NSString*)bg_color;

@end

NS_ASSUME_NONNULL_END
