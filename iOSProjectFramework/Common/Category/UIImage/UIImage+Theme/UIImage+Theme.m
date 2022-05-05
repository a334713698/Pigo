//
//  UIImage+Theme.m
//  QMMedical
//
//  Created by quanmai on 2018/4/27.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "UIImage+Theme.h"

@implementation UIImage (Theme)

- (UIImage*)imageForThemeColor:(UIColor*)color{
    return [self imageForThemeColor:color blendMode:kCGBlendModeOverlay];
}

- (UIImage*)imageForThemeColor:(UIColor*)color blendMode:(CGBlendMode)blendmode{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:blendmode alpha:1.0];
    if (blendmode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
    }
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [theImage stretchableImageWithLeftCapWidth:theImage.size.width/2 topCapHeight:theImage.size.height/2];
}

@end
