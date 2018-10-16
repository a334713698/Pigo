//
//  CalendarItemView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/16.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "CalendarItemView.h"

@implementation CalendarItemView

- (UIButton *)itemButton{
    if (!_itemButton) {
        _itemButton = [UIButton createButtonWithFontSize:adaptFont(15) andTitleColor:BLACK_COLOR andTitle:@"0" andBackgroundColor:CLEARCOLOR];
        [self addSubview:_itemButton];
        [_itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
    }
    return _itemButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParam];
    }
    return self;
}

- (void)initParam{
    [self.itemButton setBackgroundImage:[UIImage imageNamed:@"bg_checkin_unselected"] forState:UIControlStateNormal];
    [self.itemButton setBackgroundImage:[UIImage imageNamed:@"bg_checkin_selected"] forState:UIControlStateSelected];
    
    [self.itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.itemButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self.itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)itemButtonClick:(UIButton*)sender{
    sender.selected = !sender.isSelected;
    
}


@end
