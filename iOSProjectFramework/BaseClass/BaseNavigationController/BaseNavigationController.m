//
//  BaseNavigationController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationBarDelegate>

@end

@implementation BaseNavigationController

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    // 取消导航栏的透明效果
    self.navigationBar.translucent = NO;
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}


@end
