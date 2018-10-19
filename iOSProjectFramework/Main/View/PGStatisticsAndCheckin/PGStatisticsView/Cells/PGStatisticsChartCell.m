//
//  PGStatisticsChartCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsChartCell.h"
#import "AAChartKit.h"

@interface PGStatisticsChartCell ()

@property (nonatomic, strong) AAChartView *aaChartView;


@end

@implementation PGStatisticsChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    CGFloat chartViewWidth  = SCREEN_WIDTH - 8 * 2;
    CGFloat chartViewHeight = adaptHeight(PGStatisticsChartCellHeight) - 12 * 2;
    _aaChartView = [[AAChartView alloc]init];
    _aaChartView.frame = CGRectMake(8, 12, chartViewWidth, chartViewHeight);
    ////禁用 AAChartView 滚动效果(默认不禁用)
    self.aaChartView.scrollEnabled = NO;
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //_aaChartView.contentHeight = chartViewHeight;
    [self.contentView addSubview:_aaChartView];

    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//设置图表的类型(这里以设置的为柱状图为例)
    .subtitleSet(@"")//设置图表副标题
    .yAxisVisibleSet(NO)//是否显示y轴
    .legendEnabledSet(NO)//是否显示图例(图表下方可点击的带有文字的小圆点)
    .tooltipEnabledSet(NO)
    .colorsThemeSet(@[@"#1F1F1F"])
    .categoriesSet(@[@"周一",@"周二",@"周三",@"周四", @"周五",@"周六",@"周日"])//图表横轴的内容
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .dataSet(@[@1.0, @2.0, @3.0, @4.0, @5.0, @6.0, @7.0])
                 ])
    ;

    [_aaChartView aa_drawChartWithChartModel:aaChartModel];

}

@end
