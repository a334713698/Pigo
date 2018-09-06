//
//  QMTableViewCellViewModel.m
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/29.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "QMTableViewCellViewModel.h"

@implementation QMTableViewCellViewModel

+ (void)qm_addDiscWithTextField:(UITextField*)textField andHeight:(CGFloat)height{
    textField.userInteractionEnabled = NO;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, height)];
    
    UIView* point = [UIView new];
    [leftView addSubview:point];
    point.backgroundColor = [UIColor blackColor];
    
    CGFloat radius = 3;
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(radius*2);
        make.height.mas_equalTo(radius*2);
    }];
    point.layer.cornerRadius = radius;
    
    textField.leftView = leftView;
}

@end
