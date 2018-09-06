//
//  UILabel+Builder.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/29.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "UILabel+Builder.h"

@implementation UILabel (Builder)



+ (instancetype)createLabelWithFontSize:(CGFloat)fontSize andTextColor:(UIColor*)textColor andText:(NSString*)text{
    return [[self alloc] initLabelWithFontSize:fontSize andTextColor:textColor andText:text];
}

- (instancetype)initLabelWithFontSize:(CGFloat)fontSize andTextColor:(UIColor*)textColor andText:(NSString*)text{
    self = [super init];
    if (self) {
        if (fontSize) {
            self.font = [UIFont systemFontOfSize:fontSize];
        }
        if (text) {
            self.text  = text;
        }
        if (textColor) {
            self.textColor = textColor;
        }
    }
    return self;
}

@end
