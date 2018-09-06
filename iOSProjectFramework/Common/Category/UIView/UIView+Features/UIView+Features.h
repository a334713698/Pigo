//
//  UIView+Features.h
//  QMMedical
//
//  Created by quanmai on 2018/5/8.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Features)

- (void) addLineBelow;
- (void) addLineBelowHeight:(CGFloat)height lineColor:(UIColor*)color margin:(CGFloat)margin;

@end
