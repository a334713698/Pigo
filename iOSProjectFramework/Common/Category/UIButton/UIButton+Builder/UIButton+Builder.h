//
//  UIButton+Builder.h
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/29.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Builder)

+ (instancetype)createButtonWithFontSize:(CGFloat)fontSize andTitleColor:(UIColor*)textColor andTitle:(NSString*)title andBackgroundColor:(UIColor*)backgroundColor;

- (instancetype)initButtonWithFontSize:(CGFloat)fontSize andTitleColor:(UIColor*)textColor andTitle:(NSString*)title andBackgroundColor:(UIColor*)backgroundColor;


@end
