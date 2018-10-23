//
//  PGStatisticsChartCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsChartCell.h"
#import "AAChartKit.h"
#import "PGStatisticsAndCheckinViewModel.h"

@interface PGStatisticsChartCell ()

@property (nonatomic, strong) AAChartView *aaChartView;


@end

@implementation PGStatisticsChartCell{
    BOOL _hasDraw;
}

- (AAChartView *)aaChartView{
    if (!_aaChartView) {
        CGFloat leftMargin = 10;
        CGFloat topMargin = 0;
        CGFloat chartViewWidth  = SCREEN_WIDTH - leftMargin * 2;
        CGFloat chartViewHeight = adaptHeight(PGStatisticsChartCellHeight) - topMargin;
        _aaChartView = [[AAChartView alloc]init];
        _aaChartView.frame = CGRectMake(leftMargin, topMargin, chartViewWidth, chartViewHeight);
        self.aaChartView.scrollEnabled = NO;
        [self.contentView addSubview:_aaChartView];
    }
    return _aaChartView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


/**
 *  categoriesSet:x轴数据
 *  seriesSet:y轴数据
 */
- (void)updateChartWithTitle:(NSString*)title categoriesSet:(NSArray*)categoriesSet seriesSet:(NSArray*)seriesSet{
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//设置图表的类型(这里以设置的为柱状图为例)
    .titleSet(@"")//设置图表标题
    .subtitleSet(title)//设置图表副标题
    .subtitleFontSizeSet(@12)
    .yAxisVisibleSet(NO)//是否显示y轴
    .legendEnabledSet(NO)//是否显示图例(图表下方可点击的带有文字的小圆点)
    .tooltipEnabledSet(YES)
    .tooltipValueSuffixSet(@"个番茄")
    .colorsThemeSet(@[@"#1F1F1F"])
    .categoriesSet(categoriesSet)//图表横轴的内容
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"番茄")
                 .dataSet(seriesSet)
                 ])
    ;
    
    [self.aaChartView aa_refreshChartWithChartModel:aaChartModel];
}


- (void)updateCharWithTaskID:(NSInteger)task_id periodType:(PGStatisticsPeriodType)periodType dataType:(PGStatisticsChartDataType)dataType{
    NSArray* cateArr = [PGStatisticsAndCheckinViewModel getCategoriesSetWithType:periodType];
    NSArray* seriesArr = [PGStatisticsAndCheckinViewModel getSeriesSetWithType:periodType andDataType:dataType andTaskID:task_id];

    NSString* unit;
    NSString* title;
    switch (dataType) {
        case PGStatisticsChartDataTypeCount:{
            title = @"完成次数";
            unit = @"个番茄";
        }
            break;
        case PGStatisticsChartDataTypeLength:{
            title = @"专注时长";
            unit = @"分钟";
        }
            break;
        default:
            break;
    }
    
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//设置图表的类型(这里以设置的为柱状图为例)
    .titleSet(@"")//设置图表标题
    .subtitleSet(title)//设置图表副标题
    .subtitleFontSizeSet(@12)
    .yAxisVisibleSet(NO)//是否显示y轴
    .legendEnabledSet(NO)//是否显示图例(图表下方可点击的带有文字的小圆点)
    .tooltipEnabledSet(YES)
    .tooltipValueSuffixSet(unit)
    .colorsThemeSet(@[@"#1F1F1F"])
    .categoriesSet(cateArr)//图表横轴的内容
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(title)
                 .dataSet(seriesArr)
                 ])
    ;
    
    if (!_hasDraw) {
        [self.aaChartView aa_drawChartWithChartModel:aaChartModel];
        _hasDraw = YES;
    }else{
        [self.aaChartView aa_refreshChartWithChartModel:aaChartModel];
    }
}


@end
