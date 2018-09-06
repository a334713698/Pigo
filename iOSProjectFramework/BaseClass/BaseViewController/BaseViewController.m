//
//  BaseViewController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewController.h"
//#import <UMMobClick/MobClick.h>


@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - lazy load

- (QMLoadView *)qm_loadView{
    if (!_qm_loadView) {
        _qm_loadView = [QMLoadView new];
        [self.view addSubview:_qm_loadView];
    }
    [self.view bringSubviewToFront:_qm_loadView];
    return _qm_loadView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        [self.view addSubview:_topView];
        _topView.backgroundColor = MAIN_COLOR;
    }
    return _topView;
}

#pragma mark - view life func
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@-%@",NSStringFromClass([self class]),self.navTitle]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@-%@",NSStringFromClass([self class]),self.navTitle]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // 设置背景颜色
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    // 设置导航栏
    [self initNavView];
}

- (void)initNavView {
    // 导航栏左侧按钮
    _navButtonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    _navButtonLeft.frame = CGRectMake(0, 0, NavigationBarIcon, NAVIGATIONBAR_HEIGHT);
    _navButtonLeft.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _navButtonLeft.centerY = 22;
    [_navButtonLeft setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
    _navButtonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_navButtonLeft addTarget:self action:@selector(navLeftPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navButtonLeft];
    
    // 导航栏右侧按钮
    _navButtonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _navButtonRight.frame = CGRectMake(0, 0, NAVIGATIONBAR_HEIGHT + 30, NAVIGATIONBAR_HEIGHT + 14);
    _navButtonRight.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _navButtonRight.centerY = 22;
    _navButtonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_navButtonRight addTarget:self action:@selector(navRightPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navButtonRight];
        
    
    [self settingNavigationBarTintColor:QMNavTintColorMainColor];
}

#pragma mark - setNavTitle Method
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}


#pragma mark - method
- (void)setNaviTranslucent:(BOOL)naviTranslucent{
    _naviTranslucent = naviTranslucent;
    if (naviTranslucent) {
        //设置导航栏背景图片为一个空的image，这样就透明了
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        self.navigationController.navigationBar.translucent = YES;
    }else{
        //    如果不想让其他页面的导航栏变为透明 需要重置
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (void)setShowShadowImage:(BOOL)showShadowImage{
    _showShadowImage = showShadowImage;
    if (showShadowImage) {
        [self.navigationController.navigationBar setShadowImage:nil];
    }else{
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

// 修改状态栏背景色
- (void)settingStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

///设置导航栏颜色
- (void)settingNavigationBarTintColor:(QMNavTintColor)color{
    switch (color) {
        case QMNavTintColorWhiteColor:
        {
            self.navigationController.navigationBar.barTintColor = WHITE_COLOR;
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: BLACK_COLOR, NSFontAttributeName : [UIFont systemFontOfSize:18]};
            [self.navButtonLeft setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
            [self.navButtonRight setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
        }
            break;
        default:
        {
            self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: WHITE_COLOR, NSFontAttributeName : [UIFont systemFontOfSize:18]};
            [self.navButtonLeft setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
            [self.navButtonRight setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        }
            break;
    }
}

///设置导航栏左键样式
- (void)settingNavButtonLeft:(QMLeftNavButtonState)state{
    switch (state) {
        case QMLeftNavButtonStateWhite:
        {
            self.navButtonLeft.frame = CGRectMake(0, 0, 30, 30);
            self.navButtonLeft.backgroundColor = CLEARCOLOR;
            [self.navButtonLeft setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        }
            break;
        case QMLeftNavButtonStateCustom:
        {
            self.navButtonLeft.frame = CGRectMake(0, 0, 30, 30);
            self.navButtonLeft.backgroundColor = RGBA(255, 255, 255, 0.5);
            [self.navButtonLeft setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
            [self.navButtonLeft addRoundMaskWithRoundedRect:self.navButtonLeft.bounds cornerRadius:self.navButtonLeft.height/2];
        }
            break;
        case QMLeftNavButtonStateHidden:
        {
            [self hideNavButtonLeft];
        }
            break;
        default:
        {
            self.navButtonLeft.frame = CGRectMake(0, 0, NavigationBarIcon, NAVIGATIONBAR_HEIGHT);
            self.navButtonLeft.backgroundColor = CLEARCOLOR;
            [self.navButtonLeft setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        }
            break;
    }
}

///设置背景视图的高度
- (void)settingTopViewHeight:(CGFloat)height{
    if (height) {
        self.topView.height = adaptHeight(height);
    }else{
        if (_topView) {
            [_topView removeFromSuperview];
            _topView = nil;
        }
    }
}

///隐藏导航栏的按钮
- (void)hideNavButtonLeft{
    self.navButtonLeft.hidden = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}
- (void)hideNavButtonRight{
    self.navButtonRight.hidden = YES;
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)hideAllNavButton{
    [self hideNavButtonLeft];
    [self hideNavButtonRight];
}

///往前跳几个控制器
- (void)jumpForwardControllerWithCount:(NSInteger)count{
    NSArray* vcs = self.navigationController.viewControllers;
    NSInteger vcsCount = (NSInteger)vcs.count;
    if (vcsCount - 1 - count > 0) {
        [self.navigationController popToViewController:vcs[vcsCount - 1 - count] animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)popToSpecialVC:(NSString *)vcName{
    NSArray* vcs = self.navigationController.viewControllers;
    BaseViewController* targtVC = nil;
    for (int i = 0; i < vcs.count; i++) {
        id vc = vcs[i];
        if ([NSStringFromClass([vc class]) isEqualToString:vcName]) {
            targtVC = vcs[i];
            break;
        }
    }
    if (targtVC) {
        [self.navigationController popToViewController:targtVC animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}


//上一个控制器的名字
- (NSString*)previousViewControllerName{
    NSArray* vcs = self.navigationController.viewControllers;
    NSInteger vcsCount = (NSInteger)vcs.count;
    if (vcsCount < 2) {
        return nil;//没有上一页
    }else{
        id vc = vcs[vcsCount - 2];
        return NSStringFromClass([vc class]);
    }
}


#pragma mark - 按钮点击事件
/**
 *  导航左按钮事件（默认返回上一页）
 */
- (void)navLeftPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  导航右按钮事件（默认无内容）
 */

- (void)navRightPressed:(id)sender {
    DLog(@"=> navRightPressed !");
}

- (void)showLoadViewWithType:(QMLoadViewType)type touchBlock:(LoadViewTouchBlock)touchBlock{
    [self.qm_loadView settingViewWithType:type];
    self.qm_loadView.hidden = NO;
    self.qm_loadView.touchBlock = touchBlock;
}
- (void)hideEmptyView {
    self.qm_loadView.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupTableView{
    
}


@end
