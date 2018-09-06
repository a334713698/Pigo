//
//  UITableViewCell+Features.m
//  QMMedical
//
//  Created by quanmai on 2018/4/13.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "UITableViewCell+Features.h"
#import <objc/runtime.h>

static NSString *_dividingLine = @"_dividingLine";


@implementation UITableViewCell (Features)

- (void)setDividingLine:(UIView *)dividingLine{
    objc_setAssociatedObject(self, &_dividingLine, dividingLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dividingLine{
    return objc_getAssociatedObject(self, &_dividingLine);
}

- (void)settingDividingLineWithMargin:(CGFloat)margin{
    
    if(!self.dividingLine){
        self.dividingLine = [UIView new];
        [self addSubview:self.dividingLine];
        self.dividingLine.backgroundColor = LINE_COLOR;
        [self.dividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.height.mas_equalTo(0.75);
        }];
    }

    [self.dividingLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
    }];
    [self bringSubviewToFront:self.dividingLine];
}


///修改cell的图片尺寸
- (void)modifyImageSize:(CGSize)size{
    CGSize itemSize = size;
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self.imageView.image drawInRect:imageRect];
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
@end
