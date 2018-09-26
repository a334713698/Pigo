//
//  PGFocusContView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusContView.h"

const CGFloat PGFocusContViewHeight = 30;

@interface PGFocusContView()



@end

@implementation PGFocusContView

- (UIButton *)tomatoButton{
    if (!_tomatoButton) {
        _tomatoButton = [UIButton createButtonWithFontSize:adaptFont(15) andTitleColor:WHITE_COLOR andTitle:@"0" andBackgroundColor:nil];
        [self addSubview:_tomatoButton];
        [_tomatoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [_tomatoButton setImage:IMAGE(@"icon_tomato") forState:UIControlStateNormal];
        [_tomatoButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    }
    return _tomatoButton;
}

- (UIButton *)labButton{
    if(!_labButton){
        _labButton = [UIButton createButtonWithFontSize:adaptFont(15) andTitleColor:WHITE_COLOR andTitle:@"Label" andBackgroundColor:nil];
        [self addSubview:_labButton];
        [_labButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
        }];
    }
    return _labButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.tomatoButton.hidden = NO;
    UIView* line = [UIView new];
    [self addSubview:line];
    line.backgroundColor = WHITE_COLOR;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tomatoButton.mas_right).offset(adaptWidth(20));
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(adaptWidth(PGFocusContViewHeight) * 0.65);
    }];
    
    [self.labButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_right).offset(adaptWidth(20));
    }];
    
    UIView* underline = [UIView new];
    [self addSubview:underline];
    underline.backgroundColor = WHITE_COLOR;
    [underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labButton.mas_left);
        make.right.mas_equalTo(self.labButton.mas_right);
        make.top.mas_equalTo(self.labButton.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)setLabText:(NSString *)labText{
    _labText = labText;
    [self.labButton setTitle:labText forState:UIControlStateNormal];
}


@end
