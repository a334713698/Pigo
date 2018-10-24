//
//  PGFocusContView.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseView.h"

UIKIT_EXTERN const CGFloat PGFocusContViewHeight;

@interface PGFocusContView : BaseView

@property (nonatomic, copy) NSString *labText;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UIButton *labButton;

@property (nonatomic, assign) NSInteger tomatoCount;

@end
