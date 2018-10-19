//
//  PGStatisticsTodayDataCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsTodayDataCell.h"

@implementation PGStatisticsTodayDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIView* line = [UIView new];
    line.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(adaptWidth(35));
    }];
    
    UILabel* countDesc = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:TEXT_BACKGROUND_COLOR andText:@"完成次数"];
    [self addSubview:countDesc];
    [countDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(adaptWidth(PGStatisticsTodayDataCellHeight)*0.25);
        make.centerX.mas_equalTo(-SCREEN_WIDTH*0.25);
    }];
    
    UILabel* durationDesc = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:TEXT_BACKGROUND_COLOR andText:@"专注时长"];
    [self addSubview:durationDesc];
    [durationDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(adaptWidth(PGStatisticsTodayDataCellHeight)*0.25);
        make.centerX.mas_equalTo(SCREEN_WIDTH*0.25);
    }];
    
    
    UILabel* countLab = [UILabel createLabelWithFontSize:adaptFont(25) andTextColor:TEXT_BLACK_COLOR andText:@"0"];
    [self addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-SCREEN_WIDTH*0.25);
        make.bottom.mas_equalTo(countDesc.mas_top).offset(-8);
    }];
    
    UILabel* durationLab = [UILabel createLabelWithFontSize:adaptFont(25) andTextColor:TEXT_BLACK_COLOR andText:@"0"];
    [self addSubview:durationLab];
    [durationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(SCREEN_WIDTH*0.25);
        make.bottom.mas_equalTo(durationDesc.mas_top).offset(-8);
    }];
    
    _countLab = countLab;
    _durationLab = durationLab;
}

@end
