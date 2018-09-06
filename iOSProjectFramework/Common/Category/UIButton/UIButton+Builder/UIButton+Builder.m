//
//  UIButton+Builder.m
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/29.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "UIButton+Builder.h"

@implementation UIButton (Builder)

+ (instancetype)createButtonWithFontSize:(CGFloat)fontSize andTitleColor:(UIColor*)textColor andTitle:(NSString*)title andBackgroundColor:(UIColor*)backgroundColor{
    return [[UIButton alloc] initButtonWithFontSize:fontSize andTitleColor:textColor andTitle:title andBackgroundColor:backgroundColor];
}

- (instancetype)initButtonWithFontSize:(CGFloat)fontSize andTitleColor:(UIColor*)textColor andTitle:(NSString*)title andBackgroundColor:(UIColor*)backgroundColor{
    self = [super init];
    if (self) {
        if (fontSize) {
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
        if (textColor) {
            [self setTitleColor:textColor forState:UIControlStateNormal];
        }
        if (!NULLString(title)) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (backgroundColor) {
            self.backgroundColor = backgroundColor;
        }
    }
    return self;
}

@end
