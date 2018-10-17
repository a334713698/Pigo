//
//  DJTools.m
//  QMMedical
//
//  Created by quanmai on 2018/4/27.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "DJTools.h"

@implementation DJTools

///
+ (UIViewController*)topViewController{
    return [self topViewControllerWithRootViewController:WINDOW.rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


///快速显示alertVC
+ (void)showAlertWithController:(UIViewController*_Nullable)vc title:(NSString*_Nullable)title message:(NSString*_Nullable)msg cancelHandler:(void (^ __nullable)(UIAlertAction * _Nonnull action))cancelHandler doneHandler:(void (^ __nullable)(UIAlertAction * _Nonnull action))doneHandler{
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelHandler]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:doneHandler]];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

@end
