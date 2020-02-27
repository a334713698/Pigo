//
//  PGConfig.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#ifndef PGConfig_h
#define PGConfig_h

/** 统一管理常用的常量 */



// 自适应设备宽度
#define adaptWidth(w) (SCREEN_WIDTH / 375 * (w))
// 自适应设备高度
#define adaptHeight(h) (SCREEN_HEIGHT / 667 * (h))

// 字体大小自适应
#define adaptFont(font) ((SCREEN_WIDTH / 375 * (font) < 10.0f && font >= 10.0f) ? 10.0f : SCREEN_WIDTH / 375 * (font))
//#define adaptFont(font) (font)

#define WS(weakSelf)   __weak typeof(self) weakSelf = self;
#define WSObj(obj,weakObj)   __weak typeof(obj) weakObj = obj;




// 打印宏
//替换NSLog来使用，debug模式下可以打印很多方法名，行信息。
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define deallocPrint \
- (void)dealloc {\
NSLog(@"%@--dealloc", [self class]);\
}\

#define PrintFuncName DLog(@"%s",__func__);

//文件管理
#define QMFileMgr [NSFileManager defaultManager]



// 图片宏
// 定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:imageName]
#define IMAGEForThemeColor(imageName, color) [[UIImage imageNamed:@imageName] imageForThemeColor:color]


// 默认图像
#define DefaultImage [UIImage imageNamed:@"pic_placeholder"]


// 颜色宏
#define HexColor(HexStr) (QMColorFromRGB(strtol([HexStr UTF8String],NULL,16)))

// rgb颜色转换（16进制->10进制）
#define QMColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


// 背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

#define MAIN_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

// 清除背景色
#define CLEARCOLOR [UIColor clearColor]


// 字体默认颜色
#define TEXT_BACKGROUND_COLOR  [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0]
#define TEXT_BACKGROUND_COLOR_LIGHT  [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1.0]

#define TEXT_PLACEHOLDER_COLOR  [UIColor colorWithRed:208/255.0 green:208/255.0 blue:212/255.0 alpha:1.0]
#define TEXT_BLACK_COLOR  [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]

// 颜色-白色
#define WHITE_COLOR [UIColor whiteColor]
// 颜色-黑色
#define BLACK_COLOR [UIColor blackColor]


// 线条颜色
#define LINE_COLOR [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]
#define LINE_COLOR_GRAY_DARK [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]
#define LINE_COLOR_GRAY_LIGHT [UIColor colorWithRed:230/255.0 green:232/255.0 blue:237/255.0 alpha:1.0]

// NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

// NSNotificationCenter 实例化
#define NOTI_CENTER [NSNotificationCenter defaultCenter]


// 默认缓存路径
#define CACHES_PATH NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

//快速将数字转换成字符串
#define TextFromNSString(n) [NSString stringWithFormat:@"\'%@\'",n]


//判断空字符串
#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)


//快速将数字转换成字符串
#define QMStringFromCGFloat(n) [NSString stringWithFormat:@"%lf",n]
#define QMStringFromNSValue(n) [NSString stringWithFormat:@"%@",n]
#define QMStringFromNSInteger(n) [NSString stringWithFormat:@"%zd",n]


//字符串比较
#define QMEqualToString(a, b) [a isEqualToString:b]

// 单例宏
// .h
#define PROPERTY_SINGLETON_FOR_CLASS(class) + (instancetype)shared##class;

// .m
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#endif /* PGConfig_h */
