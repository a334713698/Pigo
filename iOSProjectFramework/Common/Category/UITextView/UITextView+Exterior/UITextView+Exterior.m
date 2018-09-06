//
//  UITextView+Exterior.m
//  QMMedical
//
//  Created by quanmai on 2018/4/17.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "UITextView+Exterior.h"

@implementation UITextView (Exterior)

- (void)makeInputBoxStyleWithSize:(CGSize)size{
    
    self.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
    self.backgroundColor = RGB(248, 248, 248);
    self.layer.cornerRadius = PGCornerRadius;
    self.layer.borderColor = RGB(236, 236, 236).CGColor;
    self.layer.borderWidth = 1;
}

@end
