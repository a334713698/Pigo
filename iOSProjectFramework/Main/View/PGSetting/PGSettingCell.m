//
//  PGSettingCell.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/13.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingCell.h"

@implementation PGSettingCell

#pragma mark - lazy load
- (UILabel *)qm_titleLabel{
    if (!_qm_titleLabel) {
        _qm_titleLabel = [UILabel new];
        _qm_titleLabel.font = [UIFont systemFontOfSize:adaptFont(15)];
        _qm_titleLabel.text  = @"";
        _qm_titleLabel.textColor = TEXT_BLACK_COLOR;
        [self.contentView addSubview:_qm_titleLabel];
    }
    return _qm_titleLabel;
}

- (UILabel *)qm_detailLabel{
    if (!_qm_detailLabel) {
        _qm_detailLabel = [UILabel new];
        _qm_detailLabel.font = [UIFont systemFontOfSize:adaptFont(15)];
        _qm_detailLabel.text  = @"";
        _qm_detailLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_qm_detailLabel];
    }
    return _qm_detailLabel;
}

- (UISwitch *)qm_switcher{
    if (!_qm_switcher) {
        _qm_switcher = [UISwitch new];
    }
    return _qm_switcher;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)setupSwitchEvent{
    [self.qm_switcher addTarget:self action:@selector(switchValueChnage:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchValueChnage:(UISwitch*)switcher{
    if ([self.delegate respondsToSelector:@selector(pg_cell:switchValueDidChange:)]) {
        [self.delegate pg_cell:self switchValueDidChange:switcher];
    }
}

@end
