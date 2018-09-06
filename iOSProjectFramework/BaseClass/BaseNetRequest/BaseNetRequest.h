//
//  BaseNetRequest.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


// 定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);                  // 返回数据正确
typedef void (^ErrorCodeBlock) (id errorCode);                      // 返回数据错误
typedef void (^FailureBlock) ();                                    // 网络请求失败
typedef void (^ProgressBlock) (NSProgress *uploadProgress);         // 进度数据返回
typedef void (^ErrorBlock) (id errorCode);                          // 错误信息返回
typedef void (^SuccessBlock) (id responseObject);                   // 正确数据返回

///检测网络状态
typedef void (^NetStateBlock) (AFNetworkReachabilityStatus netState);// 网络状态返回

///下载图片进度
typedef void (^DownloadProgressBlock) (CGFloat progress);// 网络状态返回



@interface BaseNetRequest : NSObject


@property (nonatomic, copy) NSString *api_url;                      // 接口地址
@property (nonatomic, copy) NSString *httpMethod;                   // 请求方式

@property (nonatomic, assign) NSTimeInterval timeoutInterval;      //请求超时时间

@property (nonatomic, strong) NSDictionary *extraDic;               //用于动态添加的一些请求参数的字典
///下载图片需要用到 记录下标
@property (nonatomic, assign) NSInteger index;

#pragma mark - 自定义初始化方法
/**
 *  自定义初始化方法
 *
 *  @param api_url 接口地址
 *
 *  @return aaa
 */
- (instancetype)initWithApiUrl:(NSString *)api_url;

#pragma mark - 网络请求
/**
 *  网络请求
 *
 *  @param block        请求成功——正确的block
 *  @param errorBlock   请求成功——错误的block
 *  @param failureBlock 请求失败的block
 */
- (void) NetRequestWithReturnValeuBlock: (ReturnValueBlock) block
                     WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                       WithFailureBlock: (FailureBlock) failureBlock;

@end
