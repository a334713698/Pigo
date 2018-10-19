//
//  PGStatisticsTodayPeriodCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsTodayPeriodCell.h"

@interface PGStatisticsTodayPeriodCell ()

@property (nonatomic, strong) UIButton *weekButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) UIButton *yearButton;

@end

@implementation PGStatisticsTodayPeriodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIButton* monthB = [UIButton createButtonWithFontSize:adaptFont(13) andTitleColor:TEXT_BACKGROUND_COLOR_LIGHT andTitle:@"月" andBackgroundColor:nil];
    [self.contentView addSubview:monthB];
    [monthB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    CGFloat space = 15;
    UIButton* weekB = [UIButton createButtonWithFontSize:adaptFont(14) andTitleColor:TEXT_BACKGROUND_COLOR_LIGHT andTitle:@"周" andBackgroundColor:nil];
    [self.contentView addSubview:weekB];
    [weekB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(monthB.mas_centerY);
        make.right.mas_equalTo(monthB.mas_left).offset(-space);
    }];

    UIButton* yearB = [UIButton createButtonWithFontSize:adaptFont(13) andTitleColor:TEXT_BACKGROUND_COLOR_LIGHT andTitle:@"年" andBackgroundColor:nil];
    [self.contentView addSubview:yearB];
    [yearB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(monthB.mas_centerY);
        make.left.mas_equalTo(monthB.mas_right).offset(space);
    }];
    
    _weekButton = weekB;
    _monthButton = monthB;
    _yearButton = yearB;
    
    [_weekButton setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_monthButton setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_yearButton setTitleColor:MAIN_COLOR forState:UIControlStateSelected];

    [_weekButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_monthButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_yearButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    _weekButton.selected = YES;

    UIView* topLine = [UIView new];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView* bottomLine = [UIView new];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];

    topLine.backgroundColor = LINE_COLOR_GRAY_LIGHT;
    bottomLine.backgroundColor = LINE_COLOR_GRAY_LIGHT;
}

- (void)btnClick:(UIButton*)sender{
    _weekButton.selected = NO;
    _monthButton.selected = NO;
    _yearButton.selected = NO;
    sender.selected = YES;
}


@end
