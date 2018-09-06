//
//  UILabel+Builder.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/29.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Builder)

+ (instancetype)createLabelWithFontSize:(CGFloat)fontSize andTextColor:(UIColor*)textColor andText:(NSString*)text;

- (instancetype)initLabelWithFontSize:(CGFloat)fontSize andTextColor:(UIColor*)textColor andText:(NSString*)text;

@end
