//
//  QMTableViewCell.m
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/19.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "QMTableViewCell.h"

const CGFloat QMTableViewCellTextViewTopMargin = 10;
const CGFloat QMTableViewCellTextViewLeftMargin = 5;

@interface QMTableViewCell()

@end

@implementation QMTableViewCell

#pragma mark - lazy load
- (UIImageView *)qm_imageView{
    if (!_qm_imageView) {
        _qm_imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_qm_imageView];
    }
    return _qm_imageView;
}

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

- (UITextField *)qm_textField{
    if (!_qm_textField) {
        _qm_textField = [UITextField new];
        _qm_textField.font = [UIFont systemFontOfSize:adaptFont(15)];
        _qm_textField.delegate = self;
        [self.contentView addSubview:_qm_textField];
    }
    return _qm_textField;
}

- (UITextView *)qm_textView{
    if (!_qm_textView) {
        _qm_textView = [UITextView new];
        _qm_textView.font = [UIFont systemFontOfSize:adaptFont(15)];
        [self.contentView addSubview:_qm_textView];
    }
    return _qm_textView;
}

- (UIView *)bottomLine{
    if(!_bottomLine){
        _bottomLine = [UIView new];
        [self addSubview:_bottomLine];
        _bottomLine.backgroundColor = LINE_COLOR;
        [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(0.75);
        }];
    }
    return _bottomLine;
}

- (UISwitch *)qm_switcher{
    if (!_qm_switcher) {
        _qm_switcher = [UISwitch new];
    }
    return _qm_switcher;
}

#pragma mark - initialize
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialSettingWithStyle:QMTableViewCellStyleDefault];
    }
    return self;
}

- (instancetype)initWithQMStyle:(QMTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [[QMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self initialSettingWithStyle:style];
    }
    return self;
}

- (void)initialSettingWithStyle:(QMTableViewCellStyle)style{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = WHITE_COLOR;
    _cellStyle = style;
    
    switch (style) {
        case QMTableViewCellStyleDefault:
            [self initSubviews_Default];
            break;
        case QMTableViewCellStyleDetail:
            [self initSubviews_Detail];
            break;
        case QMTableViewCellStyleValue1:
            [self initSubviews_Value1];
            break;
        case QMTableViewCellStyleValue2:
            [self initSubviews_Value2];
            break;
        case QMTableViewCellStyleValue3:
            [self initSubviews_Value3];
            break;
        case QMTableViewCellStyleValue4:
            [self initSubviews_Value4];
            break;
        case QMTableViewCellStyleTextField:
            [self initSubviews_TextField];
            break;
        case QMTableViewCellStyleTextView:
            [self initSubviews_TextView];
            break;
        case QMTableViewCellStyleSwitcher:
            [self initSubviews_Switcher];
            break;
        default:
            break;
    }
}


#pragma mark - initSubviews
- (void)initSubviews_Default{
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)initSubviews_Detail{
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.qm_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH / 2);
    }];

}

- (void)initSubviews_Value1{
    [self.qm_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(adaptWidth(20));
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(adaptWidth(40));
    }];
    
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qm_imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)initSubviews_Value2{
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(adaptWidth(50));
    }];
    
    [self.qm_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qm_titleLabel.mas_right).offset(8);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
}

- (void)initSubviews_Value3{
    [self.qm_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(adaptWidth(20));
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(adaptWidth(40));
        make.height.mas_equalTo(adaptWidth(40));
    }];
    
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qm_imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
    }];

    [self.qm_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)initSubviews_Value4{
    [self.qm_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(adaptWidth(20));
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(adaptWidth(40));
        make.height.mas_equalTo(adaptWidth(40));
    }];
    
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qm_imageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.mas_centerY).offset(-4);
    }];
    
    [self.qm_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qm_titleLabel.mas_left);
        make.top.mas_equalTo(self.mas_centerY).offset(4);
    }];
}


- (void)initSubviews_TextField{
    [self.qm_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(adaptWidth(20));
//        make.right.mas_equalTo(-(adaptWidth(18) + adaptWidth(20)));
        make.right.mas_equalTo(-adaptWidth(20));
        make.top.bottom.mas_equalTo(0);
    }];
}

- (void)initSubviews_TextView{
    [self.qm_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(QMTableViewCellTextViewTopMargin, QMTableViewCellTextViewLeftMargin, QMTableViewCellTextViewTopMargin, QMTableViewCellTextViewLeftMargin));
    }];
    self.qm_textView.textContainerInset = UIEdgeInsetsZero;
}

- (void)initSubviews_Switcher{
    [self.qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = self.qm_switcher;
}

#pragma mark - method
- (void)settingBottomLineWithMargin:(CGFloat)margin{
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];
    [self bringSubviewToFront:self.bottomLine];
}

- (void)makeAvatarRounded{
    [self.qm_imageView addRoundMaskWithRoundedRect:CGRectMake(0, 0, adaptWidth(40), adaptWidth(40)) cornerRadius:(adaptWidth(40) / 2)];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

@end
