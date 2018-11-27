//
//  PGTotalStatisticsTaskItemCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsTaskItemCell.h"

#define leftMargin 12
#define perLabWidth 60
#define perBGViewWidth (SCREEN_WIDTH - leftMargin * 3 - perLabWidth)

@implementation PGTotalStatisticsTaskItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    CGFloat centerYOffset = adaptWidth(PGTotalStatisticsTaskItemCellHeight)/4.0;
    
    _titleLab = [UILabel createLabelWithFontSize:adaptFont(15) andTextColor:MAIN_COLOR andText:@"title"];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(leftMargin);
    }];
    
    _perLab = [UILabel createLabelWithFontSize:adaptFont(14) andTextColor:MAIN_COLOR andText:@"0.0%"];
    _perLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_perLab];
    [_perLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(centerYOffset);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(perLabWidth);
    }];

    
    CGFloat perBGViewH = 12;
    UIView* perBGView = [UIView new];
    perBGView.backgroundColor = BACKGROUND_COLOR;
    [self.contentView addSubview:perBGView];
    [perBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.height.mas_equalTo(perBGViewH);
        make.width.mas_equalTo(perBGViewWidth);
        make.centerY.mas_equalTo(centerYOffset);
    }];
    [perBGView addRoundMaskWithRoundedRect:CGRectMake(0, 0, perBGViewWidth, perBGViewH) cornerRadius:perBGViewH/2.0];
    
    _perView = [UIView new];
    [perBGView addSubview:_perView];
    [_perView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
    }];
    [_perView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(perBGViewWidth*1);
    }];
    
    _lenLab = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:MAIN_COLOR andText:@"0小时"];
    [self.contentView addSubview:_lenLab];
    [_lenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-leftMargin);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
    }];

    UIImageView* lenIV = [[UIImageView alloc] initWithImage:[IMAGE(@"icon_timeLen") imageForThemeColor:MAIN_COLOR]];
    [self.contentView addSubview:lenIV];
    [lenIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.mas_equalTo(self.lenLab.mas_left).offset(-5);
        make.width.height.mas_equalTo(16);
    }];

    _countLab = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:MAIN_COLOR andText:@"0个"];
    [self.contentView addSubview:_countLab];
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lenIV.mas_left).offset(-leftMargin);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
    }];
    
    UIImageView* countIV = [[UIImageView alloc] initWithImage:[IMAGE(@"icon_tomato") imageForThemeColor:MAIN_COLOR]];
    [self.contentView addSubview:countIV];
    [countIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.mas_equalTo(self.countLab.mas_left).offset(-5);
        make.width.height.mas_equalTo(18);
    }];
}

- (void)setItemModel:(PGTotalStatisticsItemModel *)itemModel{
    _itemModel = itemModel;
    _titleLab.text = itemModel.taskModel.task_name;
    _perView.backgroundColor = [UIColor colorWithHexStr:itemModel.taskModel.bg_color];
    [_perView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(perBGViewWidth*itemModel.countPercent);
    }];
    _countLab.text = [NSString stringWithFormat:@"%ld个",itemModel.totalCount];
    _perLab.text = [NSString stringWithFormat:@"%.1lf%%",itemModel.countPercent*100];
    
    if (_showHour) {
        _lenLab.text = [NSString stringWithFormat:@"%.1lf小时",itemModel.totalLength / 60.0];
    }else{
        _lenLab.text = [NSString stringWithFormat:@"%ld分钟",itemModel.totalLength];
    }

}
@end
