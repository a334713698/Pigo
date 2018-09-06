//
//  BaseTabBarController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/2/27.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"

#define TAG_BTN 0x0100

@interface BaseTabBarController (){
    NSMutableArray *_buttonArr;
}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.初始化子视图
    [self initSubviews];
    
    // 2.自定义标签栏
    [self initCustomTabBarView];
}

- (void)viewDidLayoutSubviews {
    // 1.移除系统tabbar按钮
    [self removeSystemTabbarButton];
}

#pragma mark - 初始化子视图
- (void)initSubviews {
    
    
    NSArray *viewControllers = @[@"BaseViewController",@"BaseViewController",@"BaseViewController",@"BaseViewController"];
    
    // 创建导航控制器
    NSMutableArray *baseNavs = [NSMutableArray array];
    
    for (NSInteger i = 0; i < viewControllers.count; i++) {
        Class cls = NSClassFromString(viewControllers[i]);
        if (cls) {
            BaseViewController *controller = [[cls alloc] init];
            BaseNavigationController *nav= [[BaseNavigationController alloc] initWithRootViewController:controller];
            [baseNavs addObject:nav];
        }
    }
    self.viewControllers = baseNavs;
    
}

#pragma mark - 自定义标签栏
- (void)initCustomTabBarView {
    // 1.移除系统tabbar按钮
    [self removeSystemTabbarButton];
    
    // 2.创建标签栏按钮
    // 01.标签栏按钮图片名字数组，标题名字数组
    NSArray *imageNames = @[@"",@"",@"",@"",@""];
    NSArray *imageNames_selected = @[@"",@"",@"",@"",@""];
    NSArray *titles = @[@"1",@"2",@"3",@"4",@"5"];
    // 02.标签栏的宽度
    float width_button = SCREEN_WIDTH / (float)imageNames.count;
    // 03.创建按钮
    _buttonArr = [NSMutableArray new];
    for (NSInteger i = 0; i < imageNames.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width_button * i, 0, width_button, TABBAR_HEIGHT);
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + TAG_BTN;
        //        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:imageNames_selected[i]] forState:UIControlStateSelected];
        [button setImage:[[UIImage imageNamed:imageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setImage:[[UIImage imageNamed:imageNames_selected[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //        [button setTitleColor:BACKGROUND_COLOR forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:8.0];
        [self.tabBar addSubview:button];
        [_buttonArr addObject:button];
        
        if (i == 0) {//当刚进入时，选择第一个按钮作为选中状态
            button.selected = YES;
            self.selectedIndex = i;
        }
    }
}

// 标签按钮点击事件
- (void)buttonAction:(UIButton *)item {
    self.selectedIndex = item.tag - TAG_BTN;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    for (int i = 0; i < _buttonArr.count; i++) {
        UIButton *button = (UIButton *)_buttonArr[i];
        button.selected = NO;
    }
    UIButton *selectButton = (UIButton *)_buttonArr[selectedIndex];
    selectButton.selected = YES;
}

// 移除系统tabbar按钮 UITabBarButton
- (void)removeSystemTabbarButton {
    // 遍历tabbar上面的所有子视图，移除上面的按钮
    for (UIView *view in self.tabBar.subviews) {
        Class c = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:[c class]]) {
            [view removeFromSuperview];
        }
    }
}


@end
