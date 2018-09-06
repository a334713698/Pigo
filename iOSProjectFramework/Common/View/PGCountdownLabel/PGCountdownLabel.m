//
//  PGCountdownLabel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGCountdownLabel.h"

@implementation PGCountdownLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.font = [UIFont systemFontOfSize:adaptFont(100)];
    self.textColor = WHITE_COLOR;
}


@end
