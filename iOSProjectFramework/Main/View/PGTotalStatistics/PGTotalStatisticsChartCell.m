//
//  PGTotalStatisticsChartCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsChartCell.h"
#import "AAChartKit.h"

@interface PGTotalStatisticsChartCell ()

@property (nonatomic, strong) AAChartView *aaChartView;

@end


@implementation PGTotalStatisticsChartCell

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
        [self setupView];
    }
    return self;
}

- (void)setupView{
    NSArray* colorSet = @[@"#1F1F1F",@"#606D80",@"#2B4C7E",@"#567EBB",@"#4E7DA6",@"#52B5F3",@"#599A96",@"#00927C",@"#D25529",@"#F35A4A",@"#E4736D",@"#EAAF13",@"#BB780D",@"#5B4847"];
    NSArray* seriesArr = @[
                           @[@"Java"  , @67],
                           @[@"Swift" , @44],
                           @[@"Python", @83],
                           @[@"OC"    , @11],
                           @[@"Ruby"  , @42],
                           @[@"PHP"   , @31],
                           @[@"Go"    , @63],
                           @[@"C"     , @24],
                           @[@"C#"    , @88],
                           @[@"C++"   , @66],
                           ];
    
    
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .titleSet(@"")
    .subtitleSet(@"")
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .legendEnabledSet(NO)//是否显示图例(图表下方可点击的带有文字的小圆点)
    .tooltipEnabledSet(NO)//是否显示浮动提示框
    .colorsThemeSet(colorSet)//每个扇面的颜色
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .nameSet(@"语言热度占比")
                 .dataSet(seriesArr),
                 ]
               )
    ;
    
    [self.aaChartView aa_drawChartWithChartModel:aaChartModel];
}
@end
