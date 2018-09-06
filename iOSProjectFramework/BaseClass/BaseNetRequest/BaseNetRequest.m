//
//  BaseNetRequest.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseNetRequest.h"
#import <objc/runtime.h>

@implementation BaseNetRequest

- (instancetype)initWithApiUrl:(NSString *)api_url {
    self = [self init];
    if (self) {
        // 保存请求地址
        self.api_url = api_url;
        // 初始化参数
        self.httpMethod = @"POST";
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 1.初始化基本数据类型的值为-100
        // 01 获取当前类
        Class myClass = [self class];
        // 02 获取当前类中属性名字的集合
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList(myClass, &count);
        // 03 遍历所有的属性
        for (NSInteger i = 0; i < count; i++) {
            // 获取当前属性的名字
            objc_property_t property = properties[i];
            const char *char_property_name = property_getName(property);
            // 如果获取到这个属性的名字
            if (char_property_name) {
                // 转换成字符串
                NSString *property_name = [[NSString alloc] initWithCString:char_property_name encoding:NSUTF8StringEncoding];
                // 获取当前属性对应的内容
                id value = [self valueForKey:property_name];
                // 判断当前对象是数值对象
                if ([value isKindOfClass:[NSValue class]]) {
                    // 设置默认值-100
                    [self setValue:@(-100) forKey:property_name];
                }
            }
        }
    }
    return self;
}

#pragma --mark - 获取当前对象已经设置内容的数据名字和对应的内容
- (NSDictionary *)getMyClassAttributeNameAndValue {
    // 1.创建一个可变字典获取当前类的属性和内容
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    // 2.获取当前类中所有的属性名字和内容
    // 01 获取当前类
    Class myClass = [self class];
    // 02 获取当前类中属性名字的集合
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(myClass, &count);
    // 03 遍历所有的属性
    for (NSInteger i = 0; i < count; i++) {
        // 获取当前属性的名字
        objc_property_t property = properties[i];
        const char *char_property_name = property_getName(property);
        // 如果获取到这个属性的名字
        if (char_property_name) {
            // 转换成字符串
            NSString *property_name = [[NSString alloc] initWithCString:char_property_name encoding:NSUTF8StringEncoding];
            // 获取当前属性对应的内容
            id value = [self valueForKey:property_name];
            if (([value isKindOfClass:[NSData class]]) || (value != nil && [value intValue] != -100)) {
                [attributes setValue:value forKey:property_name];
            }
        }
    }
    return attributes;
}

#pragma - mark 网络请求
- (void)netRequestWithReturnValeuBlock:(ReturnValueBlock)block
                    WithErrorCodeBlock:(ErrorCodeBlock)errorBlock
                      WithFailureBlock:(FailureBlock)failureBlock
                     WithProgressBlock:(ProgressBlock)progressBlock {
    // 1.拼接完整的URL
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",API_URL,self.api_url];
    // 2.获取参数
    NSDictionary *parameter = [self getMyClassAttributeNameAndValue];
    NSMutableDictionary *params = parameter.mutableCopy;

    parameter = params.mutableCopy;
    
#warning 请求参数打印
    NSString *parameterStr = @"";
    //通过枚举类枚举
    NSEnumerator *enumerator = [parameter keyEnumerator];
    id key = [enumerator nextObject];
    while (key) {
        id obj = [parameter objectForKey:key];
        // 拼接成字符串
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key,obj];
        parameterStr = [parameterStr stringByAppendingString:str];
        key = [enumerator nextObject];
    }
    if([parameterStr length] > 0){
        parameterStr = [parameterStr substringToIndex:[parameterStr length] - 1];
    }
    DLog(@"url:%@?%@",urlString,parameterStr);
    
#warning 返回结果打印
    // 3.根据get或者post调用对应方法
    if ([self.httpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        [self netRequestGETWithRequestURL:urlString WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
            block(returnValue);
        } WithErrorCodeBlock:^(id errorCode) {
            errorBlock(errorCode);
        } WithFailureBlock:^{
            failureBlock();
        }];
    } else if ([self.httpMethod caseInsensitiveCompare:@"POST"] == NSOrderedSame) {

        [self netRequestPOSTWithRequestURL:urlString WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
            DLog(@"urlString:%@---------------returnValue:%@----------------json:%@",urlString,returnValue,[returnValue mj_JSONString]);
            block(returnValue);
        } WithErrorCodeBlock:^(id errorCode) {
            DLog(@"urlString:%@---------------errorCode:%@",urlString,errorCode);
            errorBlock(errorCode);
        } WithFailureBlock:^{
            failureBlock();
        }];
    }
}

#pragma - mark GET请求方式
- (void)netRequestGETWithRequestURL:(NSString *)requestURLString
                      WithParameter:(NSDictionary *)parameter
               WithReturnValeuBlock:(ReturnValueBlock)block
                 WithErrorCodeBlock:(ErrorCodeBlock)errorBlock
                   WithFailureBlock:(FailureBlock)failureBlock {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    //    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    manager.requestSerializer.timeoutInterval = 3.0f;
    //    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager.requestSerializer setValue:@"YZL iOS" forHTTPHeaderField:@"User-Agent"];
    [manager GET:requestURLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == NetRequestSuccess) {
            block(responseObject);
        }else{
              errorBlock(responseObject);
          }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock();
        [manager.session finishTasksAndInvalidate];
        
    }];
}

#pragma - mark POST请求方式
- (void)netRequestPOSTWithRequestURL:(NSString *)requestURLString
                       WithParameter:(NSDictionary *)parameter
                WithReturnValeuBlock:(ReturnValueBlock)block
                  WithErrorCodeBlock:(ErrorCodeBlock)errorBlock
                    WithFailureBlock:(FailureBlock)failureBlock {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
//    [manager.requestSerializer setValue:@"YZL iOS" forHTTPHeaderField:@"User-Agent"];
    
    //    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    manager.requestSerializer.timeoutInterval = 3.0f;
    //    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    [manager POST:requestURLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == NetRequestSuccess) {
            block(responseObject);
        }else{
              errorBlock(responseObject);
          }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock();
        [manager.session finishTasksAndInvalidate];
    }];
}

@end
