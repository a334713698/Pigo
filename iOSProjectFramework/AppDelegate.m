//
//  AppDelegate.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "PGFocusViewController.h"
#import "PGSettingViewController.h"
#import "PGTaskListViewController.h"
#import "LaunchViewController.h"
#import "FocusIntent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[PGConfigManager sharedPGConfigManager] setup];
    [PGUserModelInstance setup];
    [PGLocalNotiTool registerUserNotiSettings];
    
    LaunchViewController *launchScreen = [[LaunchViewController alloc] init];

    self.window.rootViewController = launchScreen;
    [self.window makeKeyAndVisible];

    //初始化 3D-Touch 和 Siri Shortcut
    [self setupShortcutItems];
    return YES;
}

- (void)setupShortcutItems{
    /**
     type 该item 唯一标识符
     localizedTitle ：标题
     localizedSubtitle：副标题
     icon：icon图标 可以使用系统类型 也可以使用自定义的图片
     userInfo：用户信息字典 自定义参数，完成具体功能需求
     */
    
    if (@available(iOS 9.0, *)) {

        UIApplicationShortcutIcon *listIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_3dtouch_list"];
        UIApplicationShortcutItem *listItem = [[UIApplicationShortcutItem alloc] initWithType:PGShortcutTypeList localizedTitle:NSLocalizedString(@"Pigo List", nil) localizedSubtitle:nil icon:listIcon userInfo:nil];

        UIApplicationShortcutIcon *settingIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon_3dtouch_set"];
        UIApplicationShortcutItem *settingItem = [[UIApplicationShortcutItem alloc] initWithType:PGShortcutTypeSetting localizedTitle:NSLocalizedString(@"Settings", nil) localizedSubtitle:nil icon:settingIcon userInfo:nil];

        /** 将items 添加到app图标 */
        [UIApplication sharedApplication].shortcutItems = @[listItem,settingItem];
    }
    
    if (@available(iOS 12.0, *)) {
        /** 初始化Siri Shortcut */
        FocusIntent *focusIntent = [[FocusIntent alloc] init];
        INInteraction *interaction = [[INInteraction alloc] initWithIntent:focusIntent response:nil];
        [interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
            DLog(@"donateInteractionWithCompletion");
        }];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
    [PGUserModelInstance updateTomato];
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler  {
    NSLog(@"按下的是%@",identifier);
    [PGLocalNotiTool handleUserNotiWithIdentifier:identifier];
    completionHandler();
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DLog(@"haha");
}

//iOS 12 only
-(BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    //根据不同的INIntent类型做不同的处理
    if ([userActivity.activityType isEqualToString:@"FocusIntent"]) {
        if ([WINDOW.rootViewController isKindOfClass:[BaseNavigationController class]]) {
            BaseNavigationController* nav = (BaseNavigationController*)WINDOW.rootViewController;
            [nav popToRootViewControllerAnimated:YES];
        }else{
            [self enterMain];
        }
    }
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
API_AVAILABLE(ios(9.0)){
    if ([shortcutItem.type isEqualToString:PGShortcutTypeSetting]){
        [self shortcutItem_setting];
    }else if (([shortcutItem.type isEqualToString:PGShortcutTypeList])){
        [self shortcutItem_list];
    }
}

- (void)enterMain {
    PGFocusViewController* focusVC = [PGFocusViewController new];
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:focusVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = navi;
}

- (void)shortcutItem_list{
    if (![WINDOW.rootViewController isKindOfClass:[BaseNavigationController class]]) {
        [self enterMain];
    }
    BaseNavigationController* nav = (BaseNavigationController*)WINDOW.rootViewController;
    [nav popToRootViewControllerAnimated:NO];
    PGTaskListViewController* next = [PGTaskListViewController new];
    [nav pushViewController:next animated:NO];
}

- (void)shortcutItem_setting{
    if (![WINDOW.rootViewController isKindOfClass:[BaseNavigationController class]]) {
        [self enterMain];
    }
    BaseNavigationController* nav = (BaseNavigationController*)WINDOW.rootViewController;
    [nav popToRootViewControllerAnimated:NO];
    PGSettingViewController* next = [PGSettingViewController new];
    [nav pushViewController:next animated:NO];
}


@end
