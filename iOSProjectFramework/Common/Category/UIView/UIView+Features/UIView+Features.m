//
//  UIView+Features.m
//  QMMedical
//
//  Created by quanmai on 2018/5/8.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "UIView+Features.h"

@implementation UIView (Features)

- (void) addLineBelow{
    [self addLineBelowHeight:0 lineColor:nil margin:0];
}

- (void) addLineBelowHeight:(CGFloat)height lineColor:(UIColor*)color margin:(CGFloat)margin{
    UIView* line = [UIView new];
    [self addSubview:line];
    line.backgroundColor = color ? :LINE_COLOR;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.bottom.mas_equalTo(0);
        if (height) {
            make.height.mas_equalTo(height);
        }else{
            make.height.mas_equalTo(1.0);
        }
    }];
}

@end
