//
//  NSString+sha1.m
//  QMMedical
//
//  Created by quanmai on 2018/5/3.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "NSString+sha1.h"
#import<CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (sha1)

- (NSString *)urlEncode{
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
#pragma clang diagnostic pop
}

- (NSString *)hmacSha1{
    const char *keyData = APP_SECRET.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);

    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", buffer[i]];
    }
    return [hash copy];
}


@end
