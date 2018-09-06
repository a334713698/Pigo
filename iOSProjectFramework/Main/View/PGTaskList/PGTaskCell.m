//
//  PGTaskCell.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTaskCell.h"

@implementation PGTaskCell

- (UILabel *)qm_titleLabel{
    if (!_qm_titleLabel) {
        _qm_titleLabel = [UILabel new];
        _qm_titleLabel.font = [UIFont boldSystemFontOfSize:adaptFont(20)];
        _qm_titleLabel.text  = @"Task";
        _qm_titleLabel.textColor = WHITE_COLOR;
        [_contView addSubview:_qm_titleLabel];
        [_qm_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.bottom.mas_equalTo(self.contView.mas_centerY).offset(-1);
        }];
    }
    return _qm_titleLabel;
}

- (UILabel *)qm_detailLabel{
    if (!_qm_detailLabel) {
        _qm_detailLabel = [UILabel new];
        _qm_detailLabel.font = [UIFont systemFontOfSize:adaptFont(14)];
        _qm_detailLabel.text  = @"25分钟";
        _qm_detailLabel.textColor = WHITE_COLOR;
        [_contView addSubview:_qm_detailLabel];
        [_qm_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.qm_titleLabel.mas_left);
            make.top.mas_equalTo(self.contView.mas_centerY).offset(7);
        }];
    }
    return _qm_detailLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = CLEARCOLOR;
    self.contentView.backgroundColor = CLEARCOLOR;
    
    CGFloat leftMargin = 10;
    _contView = [UIView new];
    [self.contentView addSubview:_contView];
    [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, leftMargin, 0, leftMargin));
    }];
    [_contView addRoundMaskWithRoundedRect:CGRectMake(0, 0, SCREEN_WIDTH - leftMargin*2, adaptWidth(PGTaskCellHeight)) cornerRadius:PGCornerRadius];

    
    _bgImageView = [UIImageView new];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_contView addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _bgImageView.clipsToBounds = YES;
    
    UIButton* playButton = [UIButton new];
    [_contView addSubview:playButton];
    [playButton setImage:IMAGE(@"icon_play") forState:UIControlStateNormal];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
}

- (void)setLabelShadow:(UILabel*)lab content:(NSString*)cont{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:cont];
    
    NSShadow* shadow = [NSShadow new];
    shadow.shadowBlurRadius = 2;
    shadow.shadowColor = BLACK_COLOR;
    shadow.shadowOffset = CGSizeMake(0, 0);
    [attributedString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, cont.length)];
    
    [lab setAttributedText:attributedString];
}

@end
