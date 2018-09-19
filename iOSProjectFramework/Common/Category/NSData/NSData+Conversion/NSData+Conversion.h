//
//  NSData+Conversion.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Conversion)

+ (NSData*)dicToData:(NSDictionary*)obj;
+ (NSData*)arrToData:(NSArray*)obj;


+ (id)dataToObj:(NSData*)data;


+ (NSDictionary*)dataToDic:(NSData*)data;
+ (NSArray*)dataToArr:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
