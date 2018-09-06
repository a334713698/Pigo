//
//  BaseModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/**
 *  自定义一个初始化方法
 *
 *  @param dic 字典类型数据
 *
 *  @return model数据
 */
- (id)initWithContentsOfDic:(NSDictionary *)dic;

@end
