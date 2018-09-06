//
//  HDJEmptyView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "HDJEmptyView.h"

@implementation HDJEmptyView{
    UILabel *_descLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    self.backgroundColor = BACKGROUND_COLOR;
    
    
    if (!_descLabel) {
        _descLabel = [UILabel new];
        [self addSubview:_descLabel];
        _descLabel.font = [UIFont systemFontOfSize:adaptFont(15)];
        _descLabel.textColor = TEXT_BACKGROUND_COLOR;
        _descLabel.text = @"暂无内容";
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        }];
        
        _emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_pic_empty"]];
        [self addSubview:_emptyImageView];
        [_emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(adaptWidth(135), adaptWidth(135)));
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(_descLabel.mas_top).offset(0);
        }];
    }
    
}

- (void)setRemindText:(NSString *)remindText {
    if (!remindText) {
        remindText = @"暂无内容";
    }
    _remindText = remindText;
    _descLabel.text = remindText;
}
@end
