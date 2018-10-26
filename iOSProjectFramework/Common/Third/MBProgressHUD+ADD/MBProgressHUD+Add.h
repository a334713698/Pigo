//
//  MBProgressHUD+Add.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
//+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
//+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showMessage:(NSString *)text view:(UIView *)view;
//
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showInfo:(NSString *)info;
+ (void)showInfo:(NSString *)info toView:(UIView *)view;

+ (void)showText:(NSString *)text;
+ (void)showText:(NSString *)text toView:(UIView *)view;

+ (void)showMutlineText:(NSString *)text;
+ (void)showMutlineText:(NSString *)text view:(UIView *)view;

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
