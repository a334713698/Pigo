//
//  PGFocusViewController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusViewController.h"
#import "PGCountdownLabel.h"
#import "PGFocusButton.h"
#import "PGFocusContView.h"
#import "PGTaskListViewController.h"
#import "PGFocusViewModel.h"

@interface PGFocusViewController ()

@property (nonatomic, strong) PGFocusContView *contView;

@property (nonatomic, strong) PGCountdownLabel *cdLabel;

@property (nonatomic, strong) PGFocusButton *leftButton;
@property (nonatomic, strong) PGFocusButton *centerButton;
@property (nonatomic, strong) PGFocusButton *rightButton;

@property (nonatomic, strong) PGFocusViewModel *viewModel;

@property (nonatomic, strong) PGTaskListModel *taskModel;

@end

@implementation PGFocusViewController

#pragma mark - lazy load
- (PGCountdownLabel *)cdLabel{
    if (!_cdLabel) {
        _cdLabel = [PGCountdownLabel new];
        [self.view addSubview:_cdLabel];
        [_cdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(adaptWidth(30));
            make.bottom.mas_equalTo(self.view.mas_centerY);
        }];
    }
    return _cdLabel;
}

- (PGFocusButton *)centerButton{
    if (!_centerButton) {
        _centerButton = [PGFocusButton new];
        [self.view addSubview:_centerButton];
        [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-adaptHeight(PGFocusBtnBottomLayout));
            make.width.mas_equalTo(adaptWidth(PGFocusCenterBtnWidth));
            make.height.mas_equalTo(adaptWidth(PGFocusBtnHeight));
        }];
        [_centerButton settingRoundedBorderWithWidth:adaptWidth(PGFocusCenterBtnWidth)];
    }
    return _centerButton;
}

- (PGFocusButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [PGFocusButton new];
        [self.view addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_centerX).offset(-adaptWidth(PGFocusBtnCenterXOffset));
            make.bottom.mas_equalTo(-adaptHeight(PGFocusBtnBottomLayout));
            make.width.mas_equalTo(adaptWidth(PGFocusSideBtnWidth));
            make.height.mas_equalTo(adaptWidth(PGFocusBtnHeight));
        }];
        [_leftButton settingRoundedBorderWithWidth:adaptWidth(PGFocusSideBtnWidth)];
    }
    return _leftButton;
}

- (PGFocusButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [PGFocusButton new];
        [self.view addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_centerX).offset(adaptWidth(PGFocusBtnCenterXOffset));
            make.bottom.mas_equalTo(-adaptHeight(PGFocusBtnBottomLayout));
            make.width.mas_equalTo(adaptWidth(PGFocusSideBtnWidth));
            make.height.mas_equalTo(adaptWidth(PGFocusBtnHeight));
        }];
        [_rightButton settingRoundedBorderWithWidth:adaptWidth(PGFocusSideBtnWidth)];
    }
    return _rightButton;
}

- (PGFocusContView *)contView{
    if (!_contView) {
        _contView = [PGFocusContView new];
        [self.view addSubview:_contView];
        [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cdLabel.mas_left);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(adaptWidth(PGFocusContViewHeight));
            make.top.mas_equalTo(self.cdLabel.mas_bottom);
        }];
        [[self.contView.labButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self toList];
        }];
    }
    return _contView;
}

- (PGFocusViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [PGFocusViewModel new];
        _viewModel.cdLabel = self.cdLabel;
        _viewModel.leftButton = self.leftButton;
        _viewModel.rightButton = self.rightButton;
        _viewModel.centerButton = self.centerButton;
        WS(weakSelf)
        self.viewModel.updateCount = ^{
            weakSelf.taskModel.count++;
            weakSelf.contView.tomatoCount = weakSelf.taskModel.count;
        };
    }
    return _viewModel;
}

#pragma mark - view func
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.naviTranslucent = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:PGConfigMgr.ScreenBright];
    
    [self updateTask];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.naviTranslucent = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)dealloc {
    NSLog(@"%@--dealloc", [self class]);
    [self removeNotiObserver];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self hideAllNavButton];
    self.view.backgroundColor = MAIN_COLOR;
    self.contView.hidden = NO;
    [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];
    [self addNotiObserver];
}


#pragma mark - SEL
- (void)toList{
    PGTaskListViewController* next = [PGTaskListViewController new];
    [self.navigationController pushViewController:next animated:YES];
}


#pragma mark - Method
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)updateTask{
    if (self.taskModel.task_id != PGUserModelInstance.currentTask.task_id) {
        self.taskModel = PGUserModelInstance.currentTask;
        self.contView.labText = self.taskModel.task_name ? :@"未知标签";
        self.contView.tomatoCount = self.taskModel.count;
        [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];
    }
    
    NSInteger stamp = [USER_DEFAULT integerForKey:Focuse_EndTimeStamp];
    if (stamp > 0 && [PGUserModelInstance checkeMissingTomato]) {
        self.viewModel.endTimeStamp = stamp;
        [self.viewModel setCurrentFocusState:PGFocusStateFocusing];
    }
}

- (void)updateCount{
    self.taskModel = PGUserModelInstance.currentTask;
    self.contView.tomatoCount = self.taskModel.count;
}

- (void)updateSettingConfig:(NSNotification*)noti{
    DLog(@"%s",__func__);
    DLog(@"%@",noti.object);
    PGSettingContentType contType = [noti.object integerValue];
    switch (contType) {
        case PGSettingContentTypeTomatoLength:
            [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];
            break;
        case PGSettingContentTypeShortBreak:
            [self.viewModel setCurrentFocusState:PGFocusStateWillShortBreak];
            break;
        case PGSettingContentTypeLongBreak:
            [self.viewModel setCurrentFocusState:PGFocusStateWillLongBreak];
            break;
        default:
            break;
    }
}

- (void)updateFocuseState:(NSNotification*)noti{
    self.viewModel.currentFocusState = [noti.object integerValue];
}

- (void)addNotiObserver{
    [NOTI_CENTER addObserver:self selector:@selector(updateCount) name:PGFocusUpdateCountNotification object:nil];
    [NOTI_CENTER addObserver:self selector:@selector(updateSettingConfig:) name:PGSettingUpdateNotification object:nil];
    [NOTI_CENTER addObserver:self selector:@selector(updateFocuseState:) name:PGFocusStateUpdateNotification object:nil];
}

- (void)removeNotiObserver{
    [NOTI_CENTER removeObserver:self name:PGFocusUpdateCountNotification object:nil];
    [NOTI_CENTER removeObserver:self name:PGSettingUpdateNotification object:nil];
    [NOTI_CENTER removeObserver:self name:PGFocusStateUpdateNotification object:nil];
}

#pragma mark - NetRequest




@end
