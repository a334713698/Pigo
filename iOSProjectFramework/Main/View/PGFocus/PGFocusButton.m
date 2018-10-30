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
}

- (void)settingRoundedBorderWithWidth:(CGFloat)width{
    [self.layer.mask removeFromSuperlayer];
    [self addRoundMaskWithRoundedRect:CGRectMake(0, 0, width, adaptWidth(PGFocusBtnHeight)) CornerRadius:(adaptWidth(PGFocusBtnHeight)/2) andBorderWidth:2 andBorderColor:WHITE_COLOR];
}

- (void)setPg_title:(NSString *)pg_title{
    _pg_title = pg_title;
    [self setTitle:pg_title forState:UIControlStateNormal];
}

- (void)setPg_state:(PGFocusButtonState)pg_state{
    _pg_state = pg_state;
    self.hidden = NO;
    switch (pg_state) {
        case PGFocusButtonStateHidden:
            self.hidden = YES;
            break;
        case PGFocusButtonStateStartFocus:
            self.pg_title = @"开始专注";
            break;
        case PGFocusButtonStateObsolete:
            self.pg_title = @"中止";
            break;
        case PGFocusButtonStateNext:
            self.pg_title = @"下一个番茄";
            break;
        case PGFocusButtonStateStartRest:
            self.pg_title = @"开始休息";
            break;
        case PGFocusButtonStateStopRest:
            self.pg_title = @"停止休息";
            break;
        default:
            break;
    }
}



@end
