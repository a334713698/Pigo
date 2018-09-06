//
//  QMLoadView.m
//  QMMedical
//
//  Created by quanmai on 2018/6/4.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "QMLoadView.h"

@implementation QMLoadView

- (YYAnimatedImageView *)loadingImageView{
    if (!_loadingImageView) {
        YYImage* image = [YYImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pic_loading" ofType:@"gif"]];
        _loadingImageView = [[YYAnimatedImageView alloc] initWithImage:image];
        [self addSubview:_loadingImageView];
        [_loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(adaptWidth(182));
            make.center.mas_equalTo(0);
        }];
    }
    return _loadingImageView;
}

- (UIButton *)emptyButton{
    if (!_emptyButton) {
        _emptyButton = [UIButton createButtonWithFontSize:adaptFont(15) andTitleColor:RGBA(225, 225, 225, 1) andTitle:@"空空如也~" andBackgroundColor:nil];
        [self addSubview:_emptyButton];
        [_emptyButton setImage:IMAGE(@"pic_data_empty") forState:UIControlStateNormal];
        [_emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(adaptWidth(187));
            make.height.mas_equalTo(adaptWidth(199));
            make.center.mas_equalTo(0);
        }];
        [_emptyButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:12];
        _emptyButton.userInteractionEnabled = NO;
    }
    return _emptyButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = WHITE_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doEmptyDataViewTapRec:)];
        [self addGestureRecognizer:tapRec];
    }
    return self;
}

#pragma mark - SEL
- (void)doEmptyDataViewTapRec:(UITapGestureRecognizer*)sender {
    DLog(@"loadview 点击事件");
    if (self.touchBlock) {
        self.touchBlock();
    }
}


#pragma mark - method
- (void)settingViewWithType:(QMLoadViewType)type{
    if (type == QMLoadViewTypeLoading) {
        [self qm_removeAllSubView];
        self.loadingImageView.hidden = NO;
    }else if (type == QMLoadViewTypeNodata){
        [self qm_removeAllSubView];
        self.emptyButton.hidden = NO;
    }
}

- (void)qm_removeAllSubView{
    if(_emptyButton){
        [_emptyButton removeFromSuperview];
        _emptyButton = nil;
    }
    if(_loadingImageView){
        [_loadingImageView removeFromSuperview];
        _loadingImageView = nil;
    }
}

@end
