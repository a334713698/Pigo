//
//  PGFocusButton.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusButton.h"

@implementation PGFocusButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.titleLabel.font = [UIFont systemFontOfSize:adaptFont(15)];
    self.backgroundColor =RGBA(255, 255, 255, 0.3);
    [self addRoundMaskWithRoundedRect:CGRectMake(0, 0, adaptWidth(PGFocusBtnWidth), adaptWidth(PGFocusBtnHeight)) CornerRadius:(adaptWidth(PGFocusBtnHeight)/2) andBorderWidth:2 andBorderColor:WHITE_COLOR];
}

- (void)setPg_title:(NSString *)pg_title{
    _pg_title = pg_title;
    [self setTitle:pg_title forState:UIControlStateNormal];
}

- (void)setPg_state:(PGFocusState)pg_state{
    _pg_state = pg_state;
    switch (pg_state) {
        case PGFocusStateStart:
            self.pg_title = @"开始专注";
            break;
        case PGFocusStateStop:
            self.pg_title = @"中断作废";
            break;
        default:
            break;
    }
}



@end
