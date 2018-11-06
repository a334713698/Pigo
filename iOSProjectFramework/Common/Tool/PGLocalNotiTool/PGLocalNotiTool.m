//
//  PGLocalNotiTool.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/11/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGLocalNotiTool.h"

@implementation PGLocalNotiTool

#pragma mark - 通知注册
+ (void)registerUserNotiSettings{
    UIUserNotificationSettings* setting  = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObjects:[self completeTomatoCategory], [self completeRestCategory], nil]]];
}

+ (UIMutableUserNotificationCategory*)completeTomatoCategory{
    UIMutableUserNotificationAction *restAction = [[UIMutableUserNotificationAction alloc] init];
    restAction.identifier = PGLocalNotiActionIDRest;
    restAction.title = @"开始休息";
    //是否取消提醒
    restAction.destructive = NO;
    //是否需要权限，例如锁屏的时候，执行操作是否需要解锁再执行
    restAction.authenticationRequired = NO;
    //启动app还是后台执行
    restAction.activationMode = UIUserNotificationActivationModeForeground;
    
    UIMutableUserNotificationAction *nextAction = [[UIMutableUserNotificationAction alloc] init];
    nextAction.identifier = PGLocalNotiActionIDNext;
    nextAction.title = @"下一个番茄";
    nextAction.destructive = NO;
    nextAction.authenticationRequired = NO;
    nextAction.activationMode = UIUserNotificationActivationModeForeground;
//    nextAction.activationMode = UIUserNotificationActivationModeBackground;

    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    //!!!这个identifier的值，在定义本地通知的时候需要
    category.identifier = PGLocalNotiCateIDCompleteTomato;
    [category setActions:@[restAction,nextAction] forContext:UIUserNotificationActionContextDefault];

    return category;
}


+ (UIMutableUserNotificationCategory*)completeRestCategory{
    UIMutableUserNotificationAction *startAction = [[UIMutableUserNotificationAction alloc] init];
    startAction.identifier = PGLocalNotiActionIDStart;
    startAction.title = @"开始专注";
    //是否取消提醒
    startAction.destructive = NO;
    //是否需要权限，例如锁屏的时候，执行操作是否需要解锁再执行
    startAction.authenticationRequired = NO;
    //启动app还是后台执行
    startAction.activationMode = UIUserNotificationActivationModeForeground;
    
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    //!!!这个identifier的值，在定义本地通知的时候需要
    category.identifier = PGLocalNotiCateIDCompleteRest;
    [category setActions:@[startAction] forContext:UIUserNotificationActionContextDefault];
    
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

@end
