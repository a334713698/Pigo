//
//  PGStatisticsView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGStatisticsView.h"
#import "PGStatisticsTodayDataCell.h"
#import "PGStatisticsChartCell.h"
#import "PGStatisticsAnnualActivityCell.h"
#import "PGStatisticsTodayPeriodCell.h"
#import "PGStatisticsAndCheckinViewModel.h"

@interface PGStatisticsView ()<UITableViewDelegate,UITableViewDataSource,PGStatisticsTodayPeriodCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *recordArr;
@property (nonatomic, strong) NSMutableDictionary<NSString*,PGTomatoRecordModel*> *recordMutableDic;

@end

@implementation PGStatisticsView{
    PGStatisticsPeriodType _periodType;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(10) + SAFEAREA_BOTTOM_HEIGHT)];
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 11.0) {
            _tableView.estimatedSectionHeaderHeight = 10;
            _tableView.estimatedSectionFooterHeight = 0.01;
        }
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[PGStatisticsChartCell class] forCellReuseIdentifier:@"PGStatisticsChartCell"];
        [_tableView registerClass:[PGStatisticsTodayPeriodCell class] forCellReuseIdentifier:@"PGStatisticsTodayPeriodCell"];
        [_tableView registerClass:[PGStatisticsAnnualActivityCell class] forCellReuseIdentifier:@"PGStatisticsAnnualActivityCell"];
        [_tableView registerClass:[PGStatisticsTodayDataCell class] forCellReuseIdentifier:@"PGStatisticsTodayDataCell"];
        
    }
    return _tableView;
}

- (NSArray *)recordArr{
    if (!_recordArr) {
        _recordArr = [PGUserModelInstance getTomatoRecordWithTaskID:self.task_id];
    }
    return _recordArr;
}

- (NSMutableDictionary<NSString *,PGTomatoRecordModel *> *)recordMutableDic{
    if (!_recordMutableDic) {
        _recordMutableDic = [NSMutableDictionary dictionary];
        NSArray<PGTomatoRecordModel*>* recordModels = [PGTomatoRecordModel mj_objectArrayWithKeyValuesArray:self.recordArr];
        for (PGTomatoRecordModel* model in recordModels) {
            [_recordMutableDic setValue:model forKey:model.add_date];
        }
    }
    return _recordMutableDic;
}

- (instancetype)initWithTaskID:(NSInteger)task_id andThemeColor:(NSString*)bg_color
{
    self = [super init];
    if (self) {
        _task_id = task_id;
        _bg_color = bg_color;
        [self setupView];
    }
    return self;
}
- (void)setupView{
    self.tableView.hidden = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 3;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        //今日
        PGStatisticsTodayDataCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsTodayDataCell"];
        NSString* todayStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
        PGTomatoRecordModel* model = self.recordMutableDic[todayStr];
        if (model) {
            cell.countLab.text = QMStringFromNSInteger(model.count);
            NSString* length;
            NSString* unit;
            if (model.length>=60) {
                length = [NSString stringWithFormat:@"%.1lf",model.length/60.0];
                unit = NSLocalizedString(@"hour", nil);
            }else{
                length = [NSString stringWithFormat:@"%ld",model.length];
                unit = NSLocalizedString(@"minutes", nil);
            }
            NSString* text = [length stringByAppendingString:unit];
            [cell.durationLab setLabelText:text Font:[UIFont systemFontOfSize:adaptFont(12)] Range:NSMakeRange(length.length, unit.length)];
        }else{
            cell.countLab.text = @"0";
            cell.durationLab.text = @"0";
        }
        return cell;
    }else if (indexPath.section == 1){
        //活跃度
        PGStatisticsAnnualActivityCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsAnnualActivityCell"];
        cell.recordMutableDic = self.recordMutableDic;
        return cell;
    }else{
        //图表
        if (indexPath.row != 1) {
            PGStatisticsChartCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsChartCell"];
            cell.bg_color = self.bg_color;
            PGStatisticsChartDataType chartDataType = (indexPath.row == 0) ? PGStatisticsChartDataTypeCount:PGStatisticsChartDataTypeLength;
            [cell updateCharWithTaskID:self.task_id periodType:_periodType dataType:chartDataType];
            return cell;
        }else{
            PGStatisticsTodayPeriodCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsTodayPeriodCell"];
            cell.delegate = self;
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        //今日
        return adaptWidth(PGStatisticsTodayDataCellHeight);
    }else if (indexPath.section == 1){
        //活跃度
        return 116;
    }else{
        //图表
        if (indexPath.row != 1) {
            return adaptWidth(PGStatisticsChartCellHeight);
        }else{
            return adaptWidth(PGStatisticsTodayPeriodCellHeight);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section == 0)? 0.01 : adaptHeight(12);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

#pragma mark - PGStatisticsTodayPeriodCell
- (void)periodCell:(PGStatisticsTodayPeriodCell*)cell andType:(PGStatisticsPeriodType)type{
    _periodType = type;
    PGStatisticsChartCell* countCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    PGStatisticsChartCell* durationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    [countCell updateCharWithTaskID:self.task_id periodType:_periodType dataType:PGStatisticsChartDataTypeCount];
    [durationCell updateCharWithTaskID:self.task_id periodType:_periodType dataType:PGStatisticsChartDataTypeLength];

}

#pragma mark - method

@end
