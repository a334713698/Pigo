//
//  QMLoadView.h
//  QMMedical
//
//  Created by quanmai on 2018/6/4.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "BaseView.h"
#import <YYImage/YYImage.h>

typedef enum : NSUInteger {
    QMLoadViewTypeLoading,
    QMLoadViewTypeNodata
} QMLoadViewType;

typedef void(^LoadViewTouchBlock)();

@interface QMLoadView : BaseView

@property (nonatomic, assign) QMLoadViewType type;
@property (nonatomic, strong) YYAnimatedImageView *loadingImageView;
@property (nonatomic, strong) UIButton *emptyButton;

@property (nonatomic, copy) LoadViewTouchBlock touchBlock;

- (void)settingViewWithType:(QMLoadViewType)type;

@end
