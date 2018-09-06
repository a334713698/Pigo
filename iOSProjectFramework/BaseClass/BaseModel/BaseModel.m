//
//  BaseModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//自定义一个初始化方法
- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        //挨个的拿到字典里面的内容,通过映射关系,写入的指定的属性里面
        [self dicToObject:dic];
    }
    return self;
}

//创建映射关系
- (NSDictionary *)keyToAtt:(NSDictionary *)dic
{
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    for (NSString *key in dic) {
        //attDic字典里面的
        //key:是传进来字典的key,
        //value:属性的名字
        [attDic setObject:key forKey:key];
    }
    return attDic;
}


//通过属性的名字获取set方法 name -> setName:
- (SEL)setingToSel:(NSString *)model_key
{
    //获取第一个字母并换换成大写
    NSString *first = [[model_key substringToIndex:1] uppercaseString];
    
    NSString *end = [model_key substringFromIndex:1];
    NSString *setSel = [NSString stringWithFormat:@"set%@%@:",first,end];
    return NSSelectorFromString(setSel);
}


//挨个的拿到字典里面的内容,通过映射关系,写入的指定的属性里面
- (void)dicToObject:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in dic) {
            //[获取映射关系字典]通过key获取属性的名字
            NSString *model_key = [[self keyToAtt:dic] objectForKey:key];
            //做一个容错
            if (model_key) {
                //判断当前属性是否存(也就是说判断该属性的set方法是否存在)
                SEL action = [self setingToSel:model_key];
                //判断方法是否存在
                if ([self respondsToSelector:action]) {
                    //属性存在,就可以把值写入到属性里面
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [self performSelector:action withObject:[dic objectForKey:key]];
#pragma clang diagnostic pop
                }
            }
        }
    }
}

@end
