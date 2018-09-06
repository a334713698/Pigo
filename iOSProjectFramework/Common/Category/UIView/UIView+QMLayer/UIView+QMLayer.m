//
//  UIView+QMLayer.m
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/16.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "UIView+QMLayer.h"

@implementation UIView (QMLayer)

//同时添加阴影和圆角
- (void)addShadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius{
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.cornerRadius = cornerRadius;
}

- (void)addShadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius andShadowColor:(UIColor*)color andShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.cornerRadius = cornerRadius;
}

//同时添加圆角和边框
- (void)addRoundMaskWithRoundedRect:(CGRect)rect CornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor*)color{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) cornerRadius:cornerRadius];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [self.layer insertSublayer:borderLayer atIndex:0];
    [self.layer setMask:maskLayer];
}

///同时添加边框
- (void)addRoundMaskWithRoundedRect:(CGRect)rect andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor*)color{
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    borderLayer.path = bezierPath.CGPath;
    
    [self.layer insertSublayer:borderLayer atIndex:0];
}

//添加虚线边框
- (void)addDottedBorderWithRoundedRect:(CGRect)rect andBorderWidth:(CGFloat)borderWidth andCornerRadius:(CGFloat)cornerRadius{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = RGB(217, 217, 217).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = rect;
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineCap = @"square";
    shapeLayer.lineDashPattern = @[@5, @5];
    [self.layer addSublayer:shapeLayer];
}

//加圆角遮罩
- (void)addRoundMaskWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius{
    [self addRoundMaskWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadius:cornerRadius];
}

//加圆角遮罩。可选择某个角
- (void)addRoundMaskWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
