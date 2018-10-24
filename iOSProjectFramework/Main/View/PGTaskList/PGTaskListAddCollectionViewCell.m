//
//  PGTaskListAddCollectionViewCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/24.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTaskListAddCollectionViewCell.h"

@implementation PGTaskListAddCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _borderView = [UIView new];
        [self.contentView addSubview:_borderView];
        [_borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_borderView addRoundMaskWithRoundedRect:CGRectMake(0, 0, adaptWidth(PGTaskListAddCollectionViewCellSize), adaptWidth(PGTaskListAddCollectionViewCellSize)) CornerRadius:5 andBorderWidth:2 andBorderColor:MAIN_COLOR];
        
        CGFloat margin = 3;
        _contView = [UIView new];
        [self.contentView addSubview:_contView];
        [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(margin, margin, margin, margin));
        }];
        [_contView addRoundMaskWithRoundedRect:CGRectMake(0, 0, adaptWidth(PGTaskListAddCollectionViewCellSize) - margin*2, adaptWidth(PGTaskListAddCollectionViewCellSize) - margin*2) cornerRadius:3];
        
    }
    return self;
}

@end
