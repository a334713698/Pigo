//
//  UIImage+QRCode.h
//  QRCode
//
//  Created by 洪冬介 on 2017/3/9.
//  Copyright © 2017年 hongdongjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

+ (UIImage *)QRImageWithContent:(NSString *)content andSize:(CGFloat)size;

@end
