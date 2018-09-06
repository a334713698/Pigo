//
//  NSData+ImageCompression.h
//  QMMedical
//
//  Created by quanmai on 2018/5/28.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ImageCompression)

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

@end
