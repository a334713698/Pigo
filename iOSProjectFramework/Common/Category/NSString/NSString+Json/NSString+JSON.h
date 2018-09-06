//
//  NSString+JSON.h
//  Wedding
//
//  Created by Morgan on 16/2/16.
//  Copyright © 2016年 HYcompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;

@end
