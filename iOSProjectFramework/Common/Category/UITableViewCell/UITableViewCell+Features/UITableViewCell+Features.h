//
//  UITableViewCell+Features.h
//  QMMedical
//
//  Created by quanmai on 2018/4/13.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Features)

@property (nonatomic, strong) UIView *dividingLine;
- (void)settingDividingLineWithMargin:(CGFloat)margin;


///修改cell的图片尺寸
- (void)modifyImageSize:(CGSize)size;

@end
