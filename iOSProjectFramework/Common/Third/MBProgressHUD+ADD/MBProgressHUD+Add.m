//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)
#pragma mark 显示信息
//+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
//{
//    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText = text;
//    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
//    // 再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
//
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//
//    // 1秒之后再消失
//    [hud hide:YES afterDelay:1.5];
//}
//
//#pragma mark 显示错误信息
//+ (void)showError:(NSString *)error toView:(UIView *)view{
//    [self show:error icon:@"error.png" view:view];
//}
//
//+ (void)showSuccess:(NSString *)success toView:(UIView *)view
//{
//    [self show:success icon:@"success.png" view:view];
//}
//
+ (void)showMessage:(NSString *)text view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0f];
}

/**
 *  显示信息 可换行
 *
 *  @param text 信息内容
 *  @param view 显示的视图
 */
+ (void)showMutlineText:(NSString *)text view:(UIView *)view {
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置模式
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0];
}

+ (void)showMutlineText:(NSString *)text {
    [self showMutlineText:text view:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self hideHUDForView:nil];
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error" view:view];
}

/**
 *  显示提示信息
 *
 *  @param info 提示信息内容
 */
+ (void)showInfo:(NSString *)info {
    [self hideHUDForView:nil];
    [self showInfo:info toView:nil];
}

/**
 *  显示提示信息
 *
 *  @param info 提示信息内容
 *  @param view 需要显示信息的视图
 */
+ (void)showInfo:(NSString *)info toView:(UIView *)view {
    [self show:info icon:@"info" view:view];
}

/**
 *  显示提示信息()
 *
 *  @param text 提示信息内容
 */
+ (void)showText:(NSString *)text {
    [self showText:text toView:nil];
}

/**
 *  显示提示信息
 *
 *  @param text 提示信息内容
 *  @param view 需要显示信息的视图
 */
+ (void)showText:(NSString *)text toView:(UIView *)view {
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.yOffset = (hud.height - 64 - 49 - 60) / 2.0;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0f];
}

/**
 *  显示加载信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message
{
    return [self showLoadingMessage:message toView:nil];
}

/**
 *  显示加载信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

@end
