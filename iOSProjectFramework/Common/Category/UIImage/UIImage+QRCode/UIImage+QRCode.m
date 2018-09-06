//
//  UIImage+QRCode.m
//  QRCode
//
//  Created by 洪冬介 on 2017/3/9.
//  Copyright © 2017年 hongdongjie. All rights reserved.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

+ (UIImage *)QRImageWithContent:(NSString *)content andSize:(CGFloat)size{
    return [self excludeFuzzyImageFromCIImage:[self createQRFromAddress:content] size:size];
}

/*! 利用系统滤镜生成二维码图*/
+ (CIImage *)createQRFromAddress: (NSString *)networkAddress{
    
    NSData * stringData = [networkAddress dataUsingEncoding: NSUTF8StringEncoding];
    
    CIFilter * qrFilter = [CIFilter filterWithName: @"CIQRCodeGenerator"];
    
    [qrFilter setValue: stringData forKey: @"inputMessage"];
    
    [qrFilter setValue: @"H" forKey: @"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
    
}
/*! 对图像进行清晰化处理*/

+ (UIImage *)excludeFuzzyImageFromCIImage: (CIImage *)image size: (CGFloat)size{
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
        //创建灰度色调空间
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext * context = [CIContext contextWithOptions: nil];
    
    CGImageRef bitmapImage = [context createCGImage: image fromRect: extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage: scaledImage];
}



@end
