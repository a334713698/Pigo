
//
//  HDJConfig.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#ifndef HDJConfig_h
#define HDJConfig_h


/** 统一管理常用的常量 */

// 服务器地址
#define API_URL @""

//图片前缀
//#define IMG_PRE_URL @"http://quanmaikeji.oss-cn-hangzhou.aliyuncs.com"


///当前设备是否是iPhoneX
#define isPhoneX ([UIScreen mainScreen].bounds.size.height == 896 | [UIScreen mainScreen].bounds.size.height == 812)
// 自适应设备宽度
#define adaptWidth(w) (SCREEN_WIDTH / 375 * (w))
// 自适应设备高度
#define adaptHeight(h) (SCREEN_HEIGHT / 667 * (h))

// 字体大小自适应
#define adaptFont(font) ((SCREEN_WIDTH / 375 * (font) < 10.0f && font >= 10.0f) ? 10.0f : SCREEN_WIDTH / 375 * (font))
//#define adaptFont(font) (font)

// 尺寸宏
#define STATUSBAR_HEIGHT (isPhoneX ? 44 : 20)
#define NAVIGATIONBAR_WIDTH 24 //不确定
#define NAVIGATIONBAR_HEIGHT 44
#define NavigationBarIcon 20
#define TABBAR_HEIGHT (isPhoneX ? 83 : 49)
#define TabBarIcon 30
#define SAFEAREA_BOTTOM_HEIGHT (isPhoneX ? 34 : 0)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define WS(weakSelf)   __weak typeof(self) weakSelf = self;
#define WSObj(obj,weakObj)   __weak typeof(obj) weakObj = obj;


// dealloc宏
#define deallocPrint \
- (void)dealloc {\
NSLog(@"%@--dealloc", [self class]);\
}\

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



//屏幕window
#define WINDOW [UIApplication sharedApplication].keyWindow

//当前显示的视图控制器
#define TOPVC [DJTools topViewController]

//文件管理
#define QMFileMgr [NSFileManager defaultManager]

// 系统宏
// 获取版本
//#define iOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
// 获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// 判断是真机还是模拟器
#if TARGET_OS_IPHONE
// iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
// iPhone Simulator
#endif


//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


// 图片宏
// 读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
// 定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:imageName]
#define IMAGEForThemeColor(imageName, color) [[UIImage imageNamed:imageName] imageForThemeColor:color]
// 默认头像
#define DefaultAvatarImage [UIImage imageNamed:@"defaultAvatar"]
#define DefaultAvatarImg(identity) [UIImage getAvatarImageWithIdentity:identity]

// 默认图像
#define DefaultImage [UIImage imageNamed:@"pic_placeholder"]

// 国际化读取宏 便于整体修改
#define QMLOCALSTRING(key,comment) NSLocalizedString(key, comment)

// 颜色宏
// rgb颜色转换（16进制->10进制）
#define QMColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


// 背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]

#define MAIN_COLOR [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]

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


//移除iOS7之后，cell默认左侧的分割线边距
#define removeCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}\

//判断空字符串
#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)


//快速将数字转换成字符串
#define TextFromNSString(n) [NSString stringWithFormat:@"\'%@\'",n]

#define QMStringFromCGFloat(n) [NSString stringWithFormat:@"%lf",n]
#define QMStringFromNSValue(n) [NSString stringWithFormat:@"%@",n]

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#define QMStringFromNSInteger(n) [NSString stringWithFormat:@"%ld",n]
#else
#define QMStringFromNSInteger(n) [NSString stringWithFormat:@"%d",n]
#endif

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



#endif /* HDJConfig_h */
