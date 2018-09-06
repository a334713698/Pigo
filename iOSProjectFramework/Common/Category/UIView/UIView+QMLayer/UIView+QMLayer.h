//
//  UIView+QMLayer.h
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/16.
//  Copyright © 2018年 Quanmai. All rights reserved.
//
// layer 层面的 扩展

#import <UIKit/UIKit.h>

@interface UIView (QMLayer)

///同时添加阴影和圆角
- (void)addShadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius;
- (void)addShadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius andShadowColor:(UIColor*)color andShadowOpacity:(CGFloat)shadowOpacity;

///同时添加圆角和边框
- (void)addRoundMaskWithRoundedRect:(CGRect)rect CornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor*)color;

///同时添加边框
- (void)addRoundMaskWithRoundedRect:(CGRect)rect andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor*)color;

//添加虚线边框
- (void)addDottedBorderWithRoundedRect:(CGRect)rect andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)cornerRadius;


///加圆角遮罩
- (void)addRoundMaskWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
///加圆角遮罩。可选择某个角
- (void)addRoundMaskWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

@end
