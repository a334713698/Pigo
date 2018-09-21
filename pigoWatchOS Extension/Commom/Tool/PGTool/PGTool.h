//
//  PGTool.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGTool : NSObject

+ (NSData*)dicToData:(NSDictionary*)obj;

+ (NSDictionary*)dataToDic:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
