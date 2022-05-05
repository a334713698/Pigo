//
//  UIImage+Theme.h
//  QMMedical
//
//  Created by quanmai on 2018/4/27.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Theme)

- (UIImage*)imageForThemeColor:(UIColor*)color;

+ (UIImage *)createImageWithColor:(UIColor *)color;

@end
