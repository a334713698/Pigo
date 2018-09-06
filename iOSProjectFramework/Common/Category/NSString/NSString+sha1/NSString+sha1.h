//
//  NSString+sha1.h
//  QMMedical
//
//  Created by quanmai on 2018/5/3.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (sha1)

- (NSString *)urlEncode;
- (NSString *)hmacSha1;

@end
