//
//  PGStatisticsChartCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsChartCell.h"

@implementation PGStatisticsChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
}

@end
