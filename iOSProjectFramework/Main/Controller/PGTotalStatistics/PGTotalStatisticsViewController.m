//
//  PGTotalStatisticsViewController.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/25.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsViewController.h"
#import "PGTotalStatisticsChartCell.h"
#import "PGStatisticsTodayDataCell.h"
#import "PGStatisticsTodayPeriodCell.h"
#import "PGTotalStatisticsViewModel.h"
#import "PGStatisticsChartCell.h"
#import "PGTotalStatisticsTaskItemCell.h"

@interface PGTotalStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,PGStatisticsTodayPeriodCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray*> *cellNames;
@property (nonatomic, strong) NSArray *itemsArr;

@end

@implementation PGTotalStatisticsViewController{
    PGStatisticsPeriodType _periodType;
}

#pragma mark - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(10))];
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 11.0) {
            _tableView.estimatedSectionHeaderHeight = 10;
            _tableView.estimatedSectionFooterHeight = 0.01;
        }
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[PGTotalStatisticsChartCell class] forCellReuseIdentifier:@"PGTotalStatisticsChartCell"];
        [_tableView registerClass:[PGStatisticsTodayDataCell class] forCellReuseIdentifier:@"PGStatisticsTodayDataCell"];
        [_tableView registerClass:[PGStatisticsTodayPeriodCell class] forCellReuseIdentifier:@"PGStatisticsTodayPeriodCell"];
        [_tableView registerClass:[PGStatisticsChartCell class] forCellReuseIdentifier:@"PGStatisticsChartCell"];
        [_tableView registerClass:[PGTotalStatisticsTaskItemCell class] forCellReuseIdentifier:@"PGTotalStatisticsTaskItemCell"];
        
    }
    return _tableView;
}

- (NSArray<NSArray*> *)cellNames{
    if (!_cellNames) {
        _cellNames = [PGTotalStatisticsViewModel getCellNameArr];
    }
    return _cellNames;
}

- (NSArray*)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [PGTotalStatisticsViewModel getItemsArr];
    }
    return _itemsArr;
}

#pragma mark - view func
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initNav];

    self.tableView.hidden = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellNames.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == self.cellNames.count) {
        return self.itemsArr.count;
    }
    return self.cellNames[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.cellNames.count) {
        PGTotalStatisticsTaskItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGTotalStatisticsTaskItemCell"];
        return cell;
    }
    NSString* cellName = self.cellNames[indexPath.section][indexPath.row];
    if (QMEqualToString(cellName, @"PGStatisticsTodayDataCell")) {
        PGStatisticsTodayDataCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsTodayDataCell"];
        return cell;
    }else if (QMEqualToString(cellName, @"PGStatisticsTodayPeriodCell")) {
        PGStatisticsTodayPeriodCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsTodayPeriodCell"];
        cell.delegate = self;
        return cell;
    }else if(QMEqualToString(cellName, @"PGTotalStatisticsChartCell")){
        PGTotalStatisticsChartCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGTotalStatisticsChartCell"];
        return cell;
    }else if (QMEqualToString(cellName, @"PGStatisticsChartCell")){
        PGStatisticsChartCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsChartCell"];
//        PGStatisticsChartDataType chartDataType = (indexPath.row == 0) ? PGStatisticsChartDataTypeCount:PGStatisticsChartDataTypeLength;
//        [cell updateCharWithTaskID:self.task_id periodType:_periodType dataType:chartDataType];
        return cell;
    }
    UITableViewCell* cell = [UITableViewCell new];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"cell：%ld-%ld",indexPath.section,indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == self.cellNames.count) {
        return adaptWidth(PGTotalStatisticsTaskItemCellHeight);
    }
    
    NSString* cellName = self.cellNames[indexPath.section][indexPath.row];
    if (QMEqualToString(cellName, @"PGStatisticsTodayDataCell")) {
        return adaptWidth(PGStatisticsTodayDataCellHeight);
    }else if (QMEqualToString(cellName, @"PGStatisticsTodayPeriodCell")) {
        return adaptWidth(PGStatisticsTodayPeriodCellHeight);
    }else if(QMEqualToString(cellName, @"PGTotalStatisticsChartCell")){
        return adaptWidth(PGTotalStatisticsChartCellHeight);
    }else if (QMEqualToString(cellName, @"PGStatisticsChartCell")){
        return adaptWidth(PGStatisticsChartCellHeight);
    }

    return adaptHeight(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return adaptHeight(12);
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.cellNames.count) {
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
    }else{
        cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0);
        cell.layoutMargins = UIEdgeInsetsMake(0, SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0);
    }
    cell.preservesSuperviewLayoutMargins = NO;
}

#pragma mark - SEL


#pragma mark - Method
- (void)initNav{
    self.navTitle = @"统计";
    
}



#pragma mark - NetRequest



@end
