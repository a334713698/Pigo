//
//  PGStatisticsView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGStatisticsView.h"

@implementation PGStatisticsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    self.backgroundColor = [UIColor yellowColor];
}

@end
