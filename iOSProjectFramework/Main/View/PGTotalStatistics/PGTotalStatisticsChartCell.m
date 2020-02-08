//
//  PGTotalStatisticsChartCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsChartCell.h"
#import "AAChartKit.h"
#import "PGTotalStatisticsViewModel.h"

@interface PGTotalStatisticsChartCell ()

@property (nonatomic, strong) AAChartView *aaChartView;

@end


@implementation PGTotalStatisticsChartCell{
    BOOL _hasDraw;
}

- (UILabel *)nodataLab{
    if (!_nodataLab) {
        _nodataLab = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:MAIN_COLOR andText:NSLocalizedString(@"No data", nil)];
        [self.contentView addSubview:_nodataLab];
        _nodataLab.textAlignment = NSTextAlignmentCenter;
        _nodataLab.backgroundColor = WHITE_COLOR;
        [_nodataLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    [self.contentView bringSubviewToFront:_nodataLab];
    return _nodataLab;
}

- (AAChartView *)aaChartView{
    if (!_aaChartView) {
        CGFloat leftMargin = 0;
        CGFloat topMargin = 0;
        CGFloat chartViewWidth  = SCREEN_WIDTH - leftMargin * 2;
        CGFloat chartViewHeight = adaptWidth(PGTotalStatisticsChartCellHeight) - topMargin;
        _aaChartView = [[AAChartView alloc]init];
        _aaChartView.frame = CGRectMake(leftMargin, topMargin, chartViewWidth, chartViewHeight);
        self.aaChartView.scrollEnabled = NO;
        [self addSubview:_aaChartView];
    }
    return _aaChartView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)updatePieCharWithPeriodType:(PGStatisticsPeriodType)periodType dataType:(PGStatisticsChartDataType)dataType{
    NSArray<PGTotalStatisticsChartModel*>* seriesArr = [PGTotalStatisticsViewModel getSeriesSetWithType:periodType andDataType:dataType];

    NSMutableArray* colorsThemeArr = [NSMutableArray array];
    NSMutableArray* elementsArr = [NSMutableArray array];
    for (PGTotalStatisticsChartModel* chartModel in seriesArr) {
        [colorsThemeArr addObject:[@"#" stringByAppendingString:chartModel.taskModel.bg_color]];
        [elementsArr addObject:@[chartModel.taskModel.task_name,chartModel.total]];
    }
    
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .titleSet(@"")
    .subtitleSet(@"")
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .legendEnabledSet(NO)//是否显示图例(图表下方可点击的带有文字的小圆点)
    .tooltipEnabledSet(NO)//是否显示浮动提示框
    .colorsThemeSet(colorsThemeArr)//每个扇面的颜色
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .nameSet(NSLocalizedString(@"Proportion of pigo", nil))
                 .dataSet(elementsArr.copy),
                 ]
               )
    ;
    
    if (!_hasDraw) {
        [self.aaChartView aa_drawChartWithChartModel:aaChartModel];
        _hasDraw = YES;
    }else{
        [self.aaChartView aa_refreshChartWithChartModel:aaChartModel];
    }
}
@end
