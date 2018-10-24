//
//  UIColor+mostColor.h
//  QMMedical
//
//  Created by quanmai on 2018/6/1.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (mostColor)

+ (UIColor*)mostColor:(UIImage*)image;

+ (UIColor*)colorWithHexStr:(NSString*)HexStr;

@end
