//
//  PGLocalNotiTool.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/11/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGLocalNotiTool.h"

@implementation PGLocalNotiTool

SYNTHESIZE_SINGLETON_FOR_CLASS(PGLocalNotiTool)
//#pragma mark - 通知注册
//+ (void)registerUserNotiSettings{
//    UIUserNotificationSettings* setting  = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
//
//
//    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObjects:[self completeTomatoCategory], [self completeRestCategory], nil]]];
//}
//
//+ (UIMutableUserNotificationCategory*)completeTomatoCategory{
//    UIMutableUserNotificationAction *restAction = [[UIMutableUserNotificationAction alloc] init];
//    restAction.identifier = PGLocalNotiActionIDRest;
//    restAction.title = NSLocalizedString(@"Take a break", nil);
//    //是否取消提醒
//    restAction.destructive = NO;
//    //是否需要权限，例如锁屏的时候，执行操作是否需要解锁再执行
//    restAction.authenticationRequired = NO;
//    //启动app还是后台执行
//    restAction.activationMode = UIUserNotificationActivationModeForeground;
//
//    UIMutableUserNotificationAction *nextAction = [[UIMutableUserNotificationAction alloc] init];
//    nextAction.identifier = PGLocalNotiActionIDNext;
//    nextAction.title = NSLocalizedString(@"Next Pigo", nil);
//    nextAction.destructive = NO;
//    nextAction.authenticationRequired = NO;
//    nextAction.activationMode = UIUserNotificationActivationModeForeground;
////    nextAction.activationMode = UIUserNotificationActivationModeBackground;
//
//    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
//    //!!!这个identifier的值，在定义本地通知的时候需要
//    category.identifier = PGLocalNotiCateIDCompleteTomato;
//    [category setActions:@[restAction,nextAction] forContext:UIUserNotificationActionContextDefault];
//
//    return category;
//}
//
//
//+ (UIMutableUserNotificationCategory*)completeRestCategory{
//    UIMutableUserNotificationAction *startAction = [[UIMutableUserNotificationAction alloc] init];
//    startAction.identifier = PGLocalNotiActionIDStart;
//    startAction.title = NSLocalizedString(@"Start focusing", nil);
//    //是否取消提醒
//    startAction.destructive = NO;
//    //是否需要权限，例如锁屏的时候，执行操作是否需要解锁再执行
//    startAction.authenticationRequired = NO;
//    //启动app还是后台执行
//    startAction.activationMode = UIUserNotificationActivationModeForeground;
//
//
//    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
//    //!!!这个identifier的值，在定义本地通知的时候需要
//    category.identifier = PGLocalNotiCateIDCompleteRest;
//    [category setActions:@[startAction] forContext:UIUserNotificationActionContextDefault];
//
//    return category;
//}
//
//
//#pragma mark - 处理通知
//+ (void)handleUserNotiWithIdentifier:(NSString*)identifier{
//    NSLog(@"按下的是%@",identifier);
//    if (QMEqualToString(identifier, PGLocalNotiActionIDStart)) {
//        [NOTI_CENTER postNotificationName:PGFocusStateUpdateNotification object:@(PGFocusStateFocusing)];
//    }else if (QMEqualToString(identifier, PGLocalNotiActionIDRest)){
//        [NOTI_CENTER postNotificationName:PGFocusStateUpdateNotification object:@(PGFocusStateShortBreaking)];
//    }else if (QMEqualToString(identifier, PGLocalNotiActionIDNext)){
//        [NOTI_CENTER postNotificationName:PGFocusStateUpdateNotification object:@(PGFocusStateFocusing)];
//    }
//}

#pragma mark - 通知注册
+ (void)registerUserNotiSettings{
    [UNUserNotificationCenter currentNotificationCenter].delegate = [self sharedPGLocalNotiTool];
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 点击允许
            NSLog(@"注册成功");
        } else {
            // 点击不允许
            NSLog(@"注册失败");
        }
    }];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:[self completeTomatoCategory], [self completeRestCategory], nil]];
    
}

+ (UNNotificationCategory *)completeTomatoCategory{
    
    UNNotificationAction *restAction = [UNNotificationAction actionWithIdentifier:PGLocalNotiActionIDRest title:NSLocalizedString(@"Take a break", nil) options:(UNNotificationActionOptionAuthenticationRequired | UNNotificationActionOptionForeground)];
        
    UNNotificationAction *nextAction = [UNNotificationAction actionWithIdentifier:PGLocalNotiActionIDNext title:NSLocalizedString(@"Next Pigo", nil) options:(UNNotificationActionOptionAuthenticationRequired | UNNotificationActionOptionForeground)];


    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:PGLocalNotiCateIDCompleteTomato actions:@[restAction,nextAction] intentIdentifiers:@[PGLocalNotiCateIDCompleteTomato] options:(UNNotificationCategoryOptionNone)];
    

    return category;
}


+ (UNNotificationCategory *)completeRestCategory{
    
    UNNotificationAction *startAction = [UNNotificationAction actionWithIdentifier:PGLocalNotiActionIDStart title:NSLocalizedString(@"Start focusing", nil) options:(UNNotificationActionOptionAuthenticationRequired | UNNotificationActionOptionForeground)];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:PGLocalNotiCateIDCompleteRest actions:@[startAction] intentIdentifiers:@[PGLocalNotiCateIDCompleteRest] options:(UNNotificationCategoryOptionNone)];
    
    return category;
}


#pragma mark - 处理通知
+ (void)handleUserNotiWithIdentifier:(NSString*)identifier{
    NSLog(@"按下的是%@",identifier);
    if (QMEqualToString(identifier, PGLocalNotiActionIDStart)) {
        [NOTI_CENTER postNotificationName:PGFocusStateUpdateNotification object:@(PGFocusStateFocusing)];
    }else if (QMEqualToString(identifier, PGLocalNotiActionIDRest)){
        [NOTI_CENTER postNotificationName:PGFocusStateUpdateNotification object:@(PGFocusStateShortBreaking)];
    }else if (QMEqualToString(identifier, PGLocalNotiActionIDNext)){
        [NOTI_CENTER postNotificationName:PGFocusStateUpdateNotification object:@(PGFocusStateFocusing)];
    }
}

#pragma mark - UNUserNotificationCenterDelegate
//仅当应用程序在前台时，才会在委托上调用该方法。如果未实现该方法或未及时调用该处理程序，则不会显示该通知。应用程序可以选择以sound, badge, alert在通知列表中显示通知。该决定应基于通知中的信息是否对用户可见。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    DLog(@"willPresentNotification");
}

//当用户通过打开应用程序，关闭通知或选择UNNotificationAction响应通知时，将在委托上调用该方法。必须在应用程序从application：didFinishLaunchingWithOptions：返回之前设置委托。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    DLog(@"didReceiveNotificationResponse");
}


@end
