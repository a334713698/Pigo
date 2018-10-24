//
//  NSString+Convert.h
//  knight
//
//  Created by 洪冬介 on 2017/3/30.
//  Copyright © 2017年 hongdongjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Convert)
//将NSString转换成十六进制的字符串
+ (NSString *)convertStringToHexStr:(NSString *)str;
@end
