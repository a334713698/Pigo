//
//  PGDataSyncModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2020/2/23.
//  Copyright © 2020 洪冬介. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGDataSyncModel : BaseModel

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, strong) NSDictionary *tables;

@property (nonatomic, strong) NSDictionary *config;


@end

NS_ASSUME_NONNULL_END
