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

@interface PGFocusViewController ()

@property (nonatomic, strong) PGCountdownLabel *cdLabel;
@property (nonatomic, strong) PGFocusButton *startButton;
@property (nonatomic, strong) PGFocusContView *contView;

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

- (PGFocusButton *)startButton{
    if (!_startButton) {
        _startButton = [PGFocusButton new];
        [self.view addSubview:_startButton];
        [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-adaptHeight(100));
            make.width.mas_equalTo(adaptWidth(PGFocusBtnWidth));
            make.height.mas_equalTo(adaptWidth(PGFocusBtnHeight));
        }];
    }
    return _startButton;
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


#pragma mark - view func
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.naviTranslucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.naviTranslucent = NO;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self hideAllNavButton];
    self.view.backgroundColor = MAIN_COLOR;
    self.cdLabel.text = @"25:00";
    self.startButton.pg_state = PGFocusStateStart;
    self.contView.hidden = NO;
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



#pragma mark - NetRequest




@end
