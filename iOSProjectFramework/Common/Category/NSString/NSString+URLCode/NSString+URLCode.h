//
//  NSString+URLCode.h
//  QMMedical
//
//  Created by quanmai on 2018/5/3.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLCode)

//上传数据转码
- (NSString*)URLEnCode;
//使用数据解码
- (NSString*)URLDeCode;

@end
