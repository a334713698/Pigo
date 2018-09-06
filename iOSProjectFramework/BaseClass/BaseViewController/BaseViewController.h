//
//  BaseViewController.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMLoadView.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView   *statusBarBgView;        // 状态栏背景视图（默认红色）
@property (nonatomic, strong) UIButton *navButtonLeft;          // 导航栏左侧按钮（默认返回）
@property (nonatomic, strong) UIButton *navButtonRight;         // 导航栏右侧按钮（默认没有）
@property (nonatomic, copy)   NSString *navTitle;               // 导航栏标题（默认无内容）

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign, getter=isNaviTranslucent) BOOL naviTranslucent;
@property (nonatomic, assign, getter=isShowShadowImage) BOOL showShadowImage;


@property (nonatomic, strong) QMLoadView *qm_loadView;

- (void)showLoadViewWithType:(QMLoadViewType)type touchBlock:(LoadViewTouchBlock)touchBlock;
- (void)hideEmptyView;

- (void)navLeftPressed;
- (void)navRightPressed:(id)sender;

///设置状态栏颜色
- (void)settingStatusBarBackgroundColor:(UIColor *)color;

///设置导航栏颜色
- (void)settingNavigationBarTintColor:(QMNavTintColor)color;

///设置导航栏左键样式
- (void)settingNavButtonLeft:(QMLeftNavButtonState)state;

///设置背景视图的高度
- (void)settingTopViewHeight:(CGFloat)height;

///隐藏导航栏的按钮
- (void)hideNavButtonLeft;
- (void)hideNavButtonRight;
- (void)hideAllNavButton;

//往前跳几个控制器
- (void)jumpForwardControllerWithCount:(NSInteger)count;

//上一个控制器的名字
- (NSString*)previousViewControllerName;

//跳到指定的控制器
- (void)popToSpecialVC:(NSString*)vcName;

- (void)setupTableView;

@end
