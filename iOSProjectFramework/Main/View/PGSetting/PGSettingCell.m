//
//  PGSettingCell.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/13.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingCell.h"


@interface PGSettingCell ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) PGSettingDataModel *selectModel;

@property (nonatomic, strong) UIPickerView *pickerView;

@end


@implementation PGSettingCell

#pragma mark - lazy load
- (UIView *)contView{
    if (!_contView) {
        _contView = [UIView new];
        [self.contentView addSubview:_contView];
        [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(adaptWidth(PGSettingCellContentHeight));
        }];
//        _contView.backgroundColor = [UIColor redColor];
    }
    return _contView;
}

- (UIView *)moreView{
    if (!_moreView) {
        _moreView = [UIView new];
        [self.contentView addSubview:_moreView];
        [_moreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(adaptWidth(PGSettingCellContentHeight));
//            make.height.mas_equalTo(adaptWidth(PGSettingCellMoreHeight));
        }];
        _moreView.backgroundColor = BACKGROUND_COLOR;
    }
    return _moreView;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        [self.moreView addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UILabel *)qm_titleLabel{
    if (!_qm_titleLabel) {
        _qm_titleLabel = [UILabel new];
        _qm_titleLabel.font = [UIFont systemFontOfSize:adaptFont(15)];
        _qm_titleLabel.text  = @"";
        _qm_titleLabel.textColor = TEXT_BLACK_COLOR;
        [self.contView addSubview:_qm_titleLabel];
        [_qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _qm_titleLabel;
}

- (UILabel *)qm_detailLabel{
    if (!_qm_detailLabel) {
        _qm_detailLabel = [UILabel new];
        _qm_detailLabel.font = [UIFont systemFontOfSize:adaptFont(15)];
        _qm_detailLabel.text  = @"";
        _qm_detailLabel.textColor = [UIColor grayColor];
        [self.contView addSubview:_qm_detailLabel];
        [_qm_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH / 2);
        }];
    }
    return _qm_detailLabel;
}

- (UISwitch *)qm_switcher{
    if (!_qm_switcher) {
        _qm_switcher = [UISwitch new];
        [self.contView addSubview:_qm_switcher];
        [_qm_switcher mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _qm_switcher;
}

- (UIImageView *)qm_accessoryImageview{
    if (!_qm_accessoryImageview) {
        _qm_accessoryImageview = [[UIImageView alloc] initWithImage:IMAGE(@"icon_cell_accessory")];
        [self.contView addSubview:_qm_accessoryImageview];
        [_qm_accessoryImageview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(PGSettingCellAccessoryWidth);
            make.height.mas_equalTo(PGSettingCellAccessoryHeight);
        }];
    }
    return _qm_accessoryImageview;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setupSwitchEvent{
    [self.qm_switcher addTarget:self action:@selector(switchValueChnage:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchValueChnage:(UISwitch*)switcher{
    if ([self.delegate respondsToSelector:@selector(pg_cell:switchValueDidChange:)]) {
        [self.delegate pg_cell:self switchValueDidChange:switcher];
    }
}

- (void)showMoreView{
//    self.moreView.hidden = NO;
    self.qm_accessoryImageview.transform = CGAffineTransformMakeRotation(M_PI*0.5);
    [self.pickerView selectRow:_selectModel.indexNum inComponent:0 animated:YES];
}

- (void)dismissMoreView{
    if (_moreView) {
        [_moreView removeFromSuperview];
        _moreView = nil;
        _pickArr = nil;
    }
    self.qm_accessoryImageview.transform = CGAffineTransformMakeRotation(0);
}

- (void)setPickArr:(NSArray *)pickArr{
    _pickArr = pickArr;
    for (PGSettingDataModel* model in pickArr) {
        if ([model.valueStr integerValue] == [self compareConfigValue]) {
            _selectModel = model;
            break;
        }
    }
}

- (NSInteger)compareConfigValue{
    switch (self.contentType) {
        case PGSettingContentTypeTomatoLength:
            return PGConfigMgr.TomatoLength;
        case PGSettingContentTypeShortBreak:
            return PGConfigMgr.ShortBreak;
        case PGSettingContentTypeLongBreak:
            return PGConfigMgr.LongBreak;
        case PGSettingContentTypeLongBreakInterval:
            return PGConfigMgr.LongBreakInterval;
        default:
            DLog(@"无匹配");
            return 0;
    }
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    PGSettingDataModel* model = self.pickArr[row];
    return QMStringFromNSValue(model.valueStr);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString* keyName;
    switch (self.contentType) {
        case PGSettingContentTypeTomatoLength:
            keyName = @"TomatoLength";
            break;
        case PGSettingContentTypeShortBreak:
            keyName = @"ShortBreak";
            break;
        case PGSettingContentTypeLongBreak:
            keyName = @"LongBreak";
            break;
        case PGSettingContentTypeLongBreakInterval:
            keyName = @"LongBreakInterval";
            break;
        default:
            DLog(@"无匹配");
            break;
    }
    if (!NULLString(keyName) && [self stateMonitor]) {
        PGSettingDataModel* model = self.pickArr[row];
        _selectModel = model;
        [PGConfigMgr setValue:model.valueStr forKey:keyName];
        [self stateMonitor];
        NSString* unit = self.cellDic[@"unit"] ? :@"";
        self.qm_detailLabel.text = [NSString stringWithFormat:@"%@ %@",model.valueStr,unit];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (BOOL)stateMonitor{
    PGSettingContentType contType = self.contentType;
    
    if (contType == PGSettingContentTypeTomatoLength && PGUserModelInstance.currentFocusState == PGFocusStateFocusing){
        [PGSettingViewModel abortReminderhandler:^{
            NSInteger index =  [self.pickArr indexOfObject:self.selectModel];
            [self.pickerView selectRow:index inComponent:0 animated:YES];
        }];
        return NO;
    }
    
    if (contType == PGSettingContentTypeTomatoLength && PGUserModelInstance.currentFocusState == PGFocusStateWillFocus) {
        [NOTI_CENTER postNotificationName:PGSettingUpdateNotification object:@(PGSettingContentTypeTomatoLength)];
    }else if (contType == PGSettingContentTypeShortBreak && PGUserModelInstance.currentFocusState == PGFocusStateWillShortBreak){
        [NOTI_CENTER postNotificationName:PGSettingUpdateNotification object:@(PGSettingContentTypeShortBreak)];
    }else if (contType == PGSettingContentTypeLongBreak && PGUserModelInstance.currentFocusState == PGFocusStateWillLongBreak){
        [NOTI_CENTER postNotificationName:PGSettingUpdateNotification object:@(PGSettingContentTypeLongBreak)];
    }
    return YES;
}



@end
