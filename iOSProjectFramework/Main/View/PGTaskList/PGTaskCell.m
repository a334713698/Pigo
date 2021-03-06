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
        [_qm_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH*0.75);
            make.bottom.mas_equalTo(self.contView.mas_centerY).offset(-1);
        }];
    }
    return _qm_titleLabel;
}

- (UILabel *)qm_detailLabel{
    if (!_qm_detailLabel) {
        _qm_detailLabel = [UILabel new];
        _qm_detailLabel.font = [UIFont systemFontOfSize:adaptFont(17)];
        _qm_detailLabel.text  = [NSString stringWithFormat:@"25%@",NSLocalizedString(@"minutes", nil)];
        _qm_detailLabel.textColor = WHITE_COLOR;
        [_contView addSubview:_qm_detailLabel];
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
    
    _playButton = [UIButton new];
    [_contView addSubview:_playButton];
    [_playButton setImage:IMAGE(@"icon_play") forState:UIControlStateNormal];
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
    [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView* tomatoIV = [[UIImageView alloc] initWithImage:IMAGE(@"icon_tomato")];
    [_contView addSubview:tomatoIV];
    [tomatoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qm_titleLabel.mas_left);
        make.top.mas_equalTo(self.contView.mas_centerY).offset(8);
        make.width.height.mas_equalTo(adaptWidth(20));
    }];
    _tomatoIV = tomatoIV;

    [self.qm_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tomatoIV.mas_right).offset(8);
//        make.centerY.mas_equalTo(tomatoIV.mas_centerY);
        make.bottom.mas_equalTo(tomatoIV.mas_bottom);
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


// 重写 insertSubview:atIndex 方法
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [super insertSubview:view atIndex:index];
    DLog(@"insertSubview");
    if ([view isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
        for (UIButton *btn in view.subviews) {

            if ([btn isKindOfClass:[UIButton class]]) {
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(adaptWidth(35));
                    make.height.mas_equalTo(adaptWidth(35));
                    make.centerX.mas_equalTo(0);
                    make.centerY.mas_equalTo(0);
                }];

                [btn setTitle:nil forState:UIControlStateNormal];
                UIImage *img = [IMAGE(@"list_deleting") imageForThemeColor:[UIColor redColor]];
                [btn setImage:img forState:UIControlStateNormal];
                [btn setImage:img forState:UIControlStateHighlighted];
            }
        }
    }
}

- (void)playButtonClick:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(taskCell:playButtonDidClick:)]) {
        [self.delegate taskCell:self playButtonDidClick:sender];
    }

}


@end
