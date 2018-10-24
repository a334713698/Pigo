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

- (UIButton *)labButton{
    if(!_labButton){
        _labButton = [UIButton createButtonWithFontSize:adaptFont(15) andTitleColor:WHITE_COLOR andTitle:@"未知标签" andBackgroundColor:nil];
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
    UIImageView* tomatoIV = [[UIImageView alloc] initWithImage:IMAGE(@"icon_tomato")];
    [self addSubview:tomatoIV];
    [tomatoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(adaptWidth(20));
    }];
    
    _countLab = [UILabel createLabelWithFontSize:adaptFont(17) andTextColor:WHITE_COLOR andText:@"0"];
    [self addSubview:_countLab];
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tomatoIV.mas_right).offset(5);
        make.centerY.mas_equalTo(tomatoIV.mas_centerY);
    }];

    
    UIView* line = [UIView new];
    [self addSubview:line];
    line.backgroundColor = WHITE_COLOR;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countLab.mas_right).offset(adaptWidth(20));
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(adaptWidth(PGFocusContViewHeight) * 0.65);
    }];
    
    [self.labButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_right).offset(adaptWidth(20));
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/2.0);
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

- (void)setTomatoCount:(NSInteger)tomatoCount{
    _tomatoCount = tomatoCount;
    _countLab.text = QMStringFromNSInteger(tomatoCount);
}

@end
