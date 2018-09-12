//
//  QMTableViewCell.h
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/19.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    QMTableViewCellStyleDefault,        //title
    QMTableViewCellStyleDetail,         //title & detail
    QMTableViewCellStyleValue1,         //imageView & title
    QMTableViewCellStyleValue2,         //title & textField
    QMTableViewCellStyleValue3,         //imageView & title & detail
    QMTableViewCellStyleValue4,         //imageView & title & detail
    QMTableViewCellStyleTextField,      //textField
    QMTableViewCellStyleTextView,       //textView
    QMTableViewCellStyleSwitcher,       //switcher
    QMTableViewCellStyleNone            //none
} QMTableViewCellStyle;


UIKIT_EXTERN const CGFloat QMTableViewCellTextViewTopMargin;
UIKIT_EXTERN const CGFloat QMTableViewCellTextViewLeftMargin;

@interface QMTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, assign) QMTableViewCellStyle cellStyle;

@property (nonatomic, strong) UIImageView* qm_imageView;

@property (nonatomic, strong) UILabel *qm_titleLabel;
@property (nonatomic, strong) UILabel *qm_detailLabel;

@property (nonatomic, strong) UITextField *qm_textField;
@property (nonatomic, strong) UITextView *qm_textView;

@property (nonatomic, strong) UISwitch *qm_switcher;


@property (nonatomic, strong) UIView *bottomLine;


- (instancetype)initWithQMStyle:(QMTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)settingBottomLineWithMargin:(CGFloat)margin;
- (void)makeAvatarRounded;

@end
